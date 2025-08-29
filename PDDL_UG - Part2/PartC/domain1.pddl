(define (domain windfarm1)
    (:requirements :strips :typing :negative-preconditions :equality :disjunctive-preconditions)

    ; -------------------------------
    ; Types
    ; -------------------------------
    (:types
        uuv         ; Represents the Unmanned Underwater Vehicle
        ship        ; Represents the ship carrying the UUV
        location    ; Represents various locations in the underwater environment
        data        ; Represents data collected by the UUV
        sample      ; Represents samples collected by the UUV
        engineer    ; Represents engineers who assist in deploying and managing the UUVs
        ship-location ; Represents specific locations on the ship, such as the bay and control centre
    )

    ; -------------------------------
    ; Constants
    ; -------------------------------
    (:constants
        uuv1 uuv2 - uuv
        engineer1 engineer2 - engineer
        bay1 bay2 control-centre1 control-centre2 - ship-location
    )

    ; -------------------------------
    ; Predicates
    ; -------------------------------
    (:predicates
        (at ?x - (either uuv ship sample engineer) ?l - location) ; Indicates that an object (UUV, ship, sample, or engineer) is at a specific location
        (connected ?l1 - location ?l2 - location) ; Indicates that two locations are connected
        (has-image ?u - uuv ?l - location) ; Indicates that the UUV has captured an image at a specific location
        (has-sonar ?u - uuv ?l - location) ; Indicates that the UUV has conducted a sonar scan at a specific location
        (has-sample ?u - uuv) ; Indicates that the UUV has collected a sample
        (image-transmitted ?u - uuv ?s - ship ?l - location) ; Indicates that the UUV has transmitted image data to the ship from a specific location
        (sonar-transmitted ?u - uuv ?s - ship ?l - location) ; Indicates that the UUV has transmitted sonar data to the ship from a specific location
        (sample-stored ?u - uuv ?s - ship ?sm - sample) ; Indicates that a sample has been stored on the ship
        (deployed ?u - uuv) ; Indicates that the UUV has been deployed
        (engineer-at ?e - engineer ?sl - ship-location) ; Indicates that an engineer is at a specific location on the ship
        (at-ship-location ?sl - ship-location ?s - ship) ; Indicates that a specific location is part of a ship
    )

    ; -------------------------------
    ; Actions
    ; -------------------------------
    (:action deploy-uuv
        :parameters (?u - uuv ?s - ship ?l - location ?e - engineer ?sl - ship-location)
        :precondition (and 
            (at ?s ?l) 
            (not (deployed ?u)) 
            (engineer-at ?e ?sl) 
            (at-ship-location ?sl ?s) 
            (or 
                (and (= ?u uuv1) (= ?e engineer1) (= ?sl bay1))
                (and (= ?u uuv2) (= ?e engineer2) (= ?sl bay2))
            )
        )
        :effect (and (at ?u ?l) (deployed ?u))
    )
    ; Deploys the UUV from the ship to a specific location, requiring the presence of an engineer at the bay.

    (:action move-uuv
        :parameters (?u - uuv ?l1 - location ?l2 - location)
        :precondition (and (at ?u ?l1) (connected ?l1 ?l2))
        :effect (and (not (at ?u ?l1)) (at ?u ?l2))
    )
    ; Moves the UUV from one location to another.

    (:action capture-image
        :parameters (?u - uuv ?l - location)
        :precondition (and (at ?u ?l))
        :effect (and (has-image ?u ?l))
    )
    ; Captures an image at a specific location.

    (:action conduct-sonar-scan
        :parameters (?u - uuv ?l - location)
        :precondition (and (at ?u ?l))
        :effect (and (has-sonar ?u ?l))
    )
    ; Conducts a sonar scan at a specific location.

    (:action collect-sample
        :parameters (?u - uuv ?l - location ?sm - sample)
        :precondition (and (at ?u ?l) (at ?sm ?l) (not (has-sample ?u)))
        :effect (and (has-sample ?u) (not (at ?sm ?l)))
    )
    ; Collects a sample from a specific location.

    (:action transmit-image-data
        :parameters (?u - uuv ?s - ship ?l - location ?e - engineer ?sl - ship-location)
        :precondition (and 
            (at ?u ?l) 
            (has-image ?u ?l) 
            (engineer-at ?e ?sl) 
            (at-ship-location ?sl ?s) 
            (or 
                (and (= ?u uuv1) (= ?e engineer1) (= ?sl control-centre1))
                (and (= ?u uuv2) (= ?e engineer2) (= ?sl control-centre2))
            )
        )
        :effect (and (image-transmitted ?u ?s ?l))
    )
    ; Transmits image data from the UUV to the ship, requiring the engineer to be at the control centre.

    (:action transmit-sonar-data
        :parameters (?u - uuv ?s - ship ?l - location ?e - engineer ?sl - ship-location)
        :precondition (and 
            (at ?u ?l) 
            (has-sonar ?u ?l) 
            (engineer-at ?e ?sl) 
            (at-ship-location ?sl ?s) 
            (or 
                (and (= ?u uuv1) (= ?e engineer1) (= ?sl control-centre1))
                (and (= ?u uuv2) (= ?e engineer2) (= ?sl control-centre2))
            )
        )
        :effect (and (sonar-transmitted ?u ?s ?l))
    )
    ; Transmits sonar data from the UUV to the ship, requiring the engineer to be at the control centre.

    (:action store-sample
        :parameters (?u - uuv ?s - ship ?sm - sample ?l - location ?e - engineer ?sl - ship-location)
        :precondition (and 
            (at ?u ?l) 
            (at ?s ?l) 
            (has-sample ?u) 
            (engineer-at ?e ?sl) 
            (at-ship-location ?sl ?s) 
            (or 
                (and (= ?u uuv1) (= ?e engineer1) (= ?sl bay1))
                (and (= ?u uuv2) (= ?e engineer2) (= ?sl bay2))
            )
        )
        :effect (and (sample-stored ?u ?s ?sm) (not (has-sample ?u)))
    )
    ; Stores a collected sample on the ship, requiring the presence of an engineer at the bay.

    (:action move-engineer
        :parameters (?e - engineer ?sl1 - ship-location ?sl2 - ship-location ?s - ship)
        :precondition (and 
            (engineer-at ?e ?sl1) 
            (at-ship-location ?sl1 ?s) 
            (at-ship-location ?sl2 ?s) 
            (or 
                (and (= ?e engineer1) (or (and (= ?sl1 bay1) (= ?sl2 control-centre1)) (and (= ?sl1 control-centre1) (= ?sl2 bay1))))
                (and (= ?e engineer2) (or (and (= ?sl1 bay2) (= ?sl2 control-centre2)) (and (= ?sl1 control-centre2) (= ?sl2 bay2))))
            )
        )
        :effect (and (not (engineer-at ?e ?sl1)) (engineer-at ?e ?sl2))
    )
    ; Moves an engineer between locations on the ship.
)








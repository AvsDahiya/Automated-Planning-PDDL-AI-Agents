(define (domain windfarm)
    (:requirements :strips :typing :negative-preconditions)

    ; -------------------------------
    ; Types
    ; -------------------------------
    (:types
        uuv         ; Represents the Unmanned Underwater Vehicle
        ship        ; Represents the ship carrying the UUV
        location    ; Represents various locations in the underwater environment
        data        ; Represents data collected by the UUV
        sample      ; Represents samples collected by the UUV
    )

    ; -------------------------------
    ; Predicates
    ; -------------------------------
    (:predicates
        (at ?x - (either uuv ship sample) ?l - location)  ; Indicates that an object (UUV, ship, or sample) is at a specific location
        (connected ?l1 - location ?l2 - location)         ; Indicates that two locations are connected
        (has-image ?u - uuv ?l - location)                ; Indicates that the UUV has captured an image at a specific location
        (has-sonar ?u - uuv ?l - location)                ; Indicates that the UUV has conducted a sonar scan at a specific location
        (has-sample ?u - uuv)                             ; Indicates that the UUV has collected a sample
        (image-transmitted ?u - uuv ?s - ship ?l - location) ; Indicates that the UUV has transmitted image data to the ship from a specific location
        (sonar-transmitted ?u - uuv ?s - ship ?l - location) ; Indicates that the UUV has transmitted sonar data to the ship from a specific location
        (sample-stored ?u - uuv ?s - ship ?sm - sample)   ; Indicates that a sample has been stored on the ship
        (deployed ?u - uuv)                               ; Indicates that the UUV has been deployed
    )

    ; -------------------------------
    ; Actions
    ; -------------------------------
    (:action deploy-uuv
        :parameters (?u - uuv ?s - ship ?l - location)
        :precondition (and (at ?s ?l) (not (deployed ?u))) ; Preconditions: The ship is at the location, and the UUV is not yet deployed
        :effect (and (at ?u ?l) (deployed ?u))             ; Effects: The UUV is now at the location and marked as deployed
    )

    (:action move-uuv
        :parameters (?u - uuv ?l1 - location ?l2 - location)
        :precondition (and (at ?u ?l1) (connected ?l1 ?l2)) ; Preconditions: The UUV is at the starting location, and the locations are connected
        :effect (and (not (at ?u ?l1)) (at ?u ?l2))         ; Effects: The UUV is no longer at the starting location and is now at the destination location
    )

    (:action capture-image
        :parameters (?u - uuv ?l - location)
        :precondition (and (at ?u ?l))                      ; Preconditions: The UUV is at the specified location
        :effect (and (has-image ?u ?l))                     ; Effects: The UUV has captured an image at the location
    )

    (:action conduct-sonar-scan
        :parameters (?u - uuv ?l - location)
        :precondition (and (at ?u ?l))                      ; Preconditions: The UUV is at the specified location
        :effect (and (has-sonar ?u ?l))                     ; Effects: The UUV has conducted a sonar scan at the location
    )

    (:action collect-sample
        :parameters (?u - uuv ?l - location ?sm - sample)
        :precondition (and (at ?u ?l) (at ?sm ?l) (not (has-sample ?u))) ; Preconditions: The UUV and the sample are at the same location, and the UUV does not already have a sample
        :effect (and (has-sample ?u) (not (at ?sm ?l)))     ; Effects: The UUV has collected the sample, and the sample is no longer at the location
    )
    
    (:action transmit-image-data
        :parameters (?u - uuv ?s - ship ?l - location)
        :precondition (and (at ?u ?l) (has-image ?u ?l))    ; Preconditions: The UUV is at the location and has captured an image there
        :effect (and (image-transmitted ?u ?s ?l))         ; Effects: The image data has been transmitted from the UUV to the ship
    )

    (:action transmit-sonar-data
        :parameters (?u - uuv ?s - ship ?l - location)
        :precondition (and (at ?u ?l) (has-sonar ?u ?l))    ; Preconditions: The UUV is at the location and has conducted a sonar scan there
        :effect (and (sonar-transmitted ?u ?s ?l))         ; Effects: The sonar data has been transmitted from the UUV to the ship
    )

    (:action store-sample
        :parameters (?u - uuv ?s - ship ?sm - sample ?l - location)
        :precondition (and (at ?u ?l) (at ?s ?l) (has-sample ?u)) ; Preconditions: The UUV and the ship are at the same location, and the UUV has a sample
        :effect (and (sample-stored ?u ?s ?sm) (not (has-sample ?u))) ; Effects: The sample has been stored on the ship, and the UUV no longer has the sample
    )
)

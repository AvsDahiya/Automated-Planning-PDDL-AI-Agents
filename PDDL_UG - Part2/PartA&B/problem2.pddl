(define (problem windfarm-mission-2)
    (:domain windfarm)  ; Specifies that this problem instance uses the "windfarm" domain

    ; -------------------------------
    ; Objects
    ; -------------------------------
    (:objects
        uuv1 - uuv          ; Defines uuv1 as an object of type uuv (Unmanned Underwater Vehicle)
        ship1 - ship        ; Defines ship1 as an object of type ship
        wp1 wp2 wp3 wp4 wp5 - location  ; Defines wp1, wp2, wp3, wp4, and wp5 as objects of type location (waypoints)
        img1 sonar1 - data  ; Defines img1 and sonar1 as objects of type data (collected data)
        sample1 - sample    ; Defines sample1 as an object of type sample
    )

    ; -------------------------------
    ; Initial State
    ; -------------------------------
    (:init
        (at ship1 wp1)  ; The ship (ship1) is initially at waypoint wp1
        (at sample1 wp1)  ; The sample (sample1) is initially at waypoint wp1
        (connected wp1 wp2)  ; Waypoint wp1 is connected to waypoint wp2
        (connected wp1 wp4)  ; Waypoint wp1 is connected to waypoint wp4
        (connected wp2 wp3)  ; Waypoint wp2 is connected to waypoint wp3
        (connected wp3 wp5)  ; Waypoint wp3 is connected to waypoint wp5
        (connected wp4 wp3)  ; Waypoint wp4 is connected to waypoint wp3
        (connected wp5 wp1)  ; Waypoint wp5 is connected to waypoint wp1
    )

    ; -------------------------------
    ; Goal State
    ; -------------------------------
    (:goal (and
        (image-transmitted uuv1 ship1 wp5)  ; The UUV (uuv1) must transmit image data to the ship (ship1) from waypoint wp5
        (sonar-transmitted uuv1 ship1 wp3)  ; The UUV (uuv1) must transmit sonar data to the ship (ship1) from waypoint wp3
        (sample-stored uuv1 ship1 sample1)  ; The UUV (uuv1) must store the collected sample (sample1) on the ship (ship1)
    ))
)

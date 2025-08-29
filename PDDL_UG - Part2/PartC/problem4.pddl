(define (problem windfarm-mission-4)
    (:domain windfarm1)  ; Specifies that this problem instance uses the "windfarm1" domain
    (:requirements :disjunctive-preconditions)  ; Specifies that this problem allows disjunctive preconditions

    ; -------------------------------
    ; Objects
    ; -------------------------------
    (:objects
        ship1 ship2 - ship       ; Defines ship1 and ship2 as objects of type ship
        wp1 wp2 wp3 wp4 wp5 wp6 - location  ; Defines wp1, wp2, wp3, wp4, wp5, and wp6 as objects of type location (waypoints)
        img1 img2 sonar1 sonar2 - data  ; Defines img1, img2, sonar1, and sonar2 as objects of type data (collected data)
        sample1 sample2 - sample ; Defines sample1 and sample2 as objects of type sample
    )

    ; -------------------------------
    ; Initial State
    ; -------------------------------
    (:init 
        (at uuv1 wp2)  ; The UUV (uuv1) is initially at waypoint wp2
        (deployed uuv1)  ; The UUV (uuv1) is already deployed
        (at ship1 wp2)  ; The ship (ship1) is initially at waypoint wp2
        (at ship2 wp5)  ; The ship (ship2) is initially at waypoint wp5
        (at sample1 wp1)  ; The sample (sample1) is initially at waypoint wp1
        (at sample2 wp5)  ; The sample (sample2) is initially at waypoint wp5
        (connected wp1 wp2)  ; Waypoint wp1 is connected to waypoint wp2
        (connected wp2 wp1)  ; Waypoint wp2 is connected to waypoint wp1 (bidirectional connection)
        (connected wp2 wp3)  ; Waypoint wp2 is connected to waypoint wp3
        (connected wp3 wp5)  ; Waypoint wp3 is connected to waypoint wp5
        (connected wp5 wp3)  ; Waypoint wp5 is connected to waypoint wp3 (bidirectional connection)
        (connected wp5 wp6)  ; Waypoint wp5 is connected to waypoint wp6
        (connected wp6 wp4)  ; Waypoint wp6 is connected to waypoint wp4
        (connected wp4 wp2)  ; Waypoint wp4 is connected to waypoint wp2
        (connected wp2 wp4)  ; Waypoint wp2 is connected to waypoint wp4 (bidirectional connection)
        (engineer-at engineer1 control-centre1)  ; Engineer1 is initially at control-centre1
        (engineer-at engineer2 bay2)  ; Engineer2 is initially at bay2
        (at-ship-location bay1 ship1)  ; Bay1 is a location on ship1
        (at-ship-location control-centre1 ship1)  ; Control-centre1 is a location on ship1
        (at-ship-location bay2 ship2)  ; Bay2 is a location on ship2
        (at-ship-location control-centre2 ship2)  ; Control-centre2 is a location on ship2
    )

    ; -------------------------------
    ; Goal State
    ; -------------------------------
    (:goal (and
        (image-transmitted uuv1 ship1 wp2)  ; The UUV (uuv1) must transmit image data to the ship (ship1) from waypoint wp2
        (sonar-transmitted uuv2 ship2 wp4)  ; The UUV (uuv2) must transmit sonar data to the ship (ship2) from waypoint wp4
        (image-transmitted uuv1 ship1 wp3)  ; The UUV (uuv1) must transmit image data to the ship (ship1) from waypoint wp3
        (sonar-transmitted uuv2 ship2 wp6)  ; The UUV (uuv2) must transmit sonar data to the ship (ship2) from waypoint wp6
        (sample-stored uuv1 ship1 sample1)  ; The UUV (uuv1) must store the collected sample (sample1) on the ship (ship1)
        (sample-stored uuv2 ship2 sample2)  ; The UUV (uuv2) must store the collected sample (sample2) on the ship (ship2)
    ))
)












//
//  MKMapViewExtension.swift
//  CovidTracker
//
//  Created by Sahil Luna on 26/04/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
    
    func centerToLocation(_ location:CLLocation,regionsRadius:CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate,
                                                       latitudinalMeters: regionsRadius,
                                                       longitudinalMeters: regionsRadius)
        setRegion(coordinateRegion,
                  animated: true)
    }
}

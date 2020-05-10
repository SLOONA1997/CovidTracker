//
//  GeoJsonFeatureCollection.swift
//  CovidTracker
//
//  Created by Sahil Luna on 08/05/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import Foundation

class GeoJsonFeatureCollection {
    //Feature points
    var features = [GeoJsonFeature]()
    
    init(geoJsonData:[String:Any]) {
        if let featuresData = geoJsonData[APIConstants.Keys.features] as? [[String:Any]] {
            for featurePoint in featuresData {
                self.features.append(GeoJsonFeature.init(featureData: featurePoint))
            }
        }
    }
}

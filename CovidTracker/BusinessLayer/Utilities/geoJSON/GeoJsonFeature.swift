//
//  GeoJsonFeature.swift
//  CovidTracker
//
//  Created by Sahil Luna on 07/05/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import Foundation

class GeoJsonFeature {
    //Feature data
    var geomatry : Geomatry?
    var properties : Properties?
    
    init(featureData:[String:Any]) {
        if let geomatryData = featureData[APIConstants.Keys.geometry] as? [String:Any] {
            self.geomatry = Geomatry.init(geomaryJson: geomatryData)
        }
        if let propertiesData = featureData[APIConstants.Keys.properties] as? [String:Any] {
            self.properties = Properties.init(propertiesData)
        }
    }
    
}

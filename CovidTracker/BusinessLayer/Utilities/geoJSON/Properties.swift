//
//  Properties.swift
//  CovidTracker
//
//  Created by Sahil Luna on 08/05/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import Foundation
import MapKit

class Properties : DataInfo{
    //Data
    var annotationPoint : MKPointAnnotation?
    
    override init(_ propertiesJson:[String:Any]) {
        super.init(propertiesJson)
        let stateName = propertiesJson[APIConstants.Keys.name] as? String
        var latitude = propertiesJson[APIConstants.Keys.latitude] as? Double
        var longitude = propertiesJson[APIConstants.Keys.longitude] as? Double
        if latitude == nil,let latStr = propertiesJson[APIConstants.Keys.latitude] as? String,let lat = Double(latStr) {
            latitude = lat
        }
        if longitude == nil,let longStr = propertiesJson[APIConstants.Keys.longitude] as? String,let long = Double(longStr) {
            longitude = long
        }
        annotationPoint = MKPointAnnotation.init()
        annotationPoint?.title = stateName
        annotationPoint?.subtitle = getFormattedInfo()
        annotationPoint?.coordinate = CLLocationCoordinate2D.init(latitude: latitude ?? 0.0,
                                                            longitude: longitude ?? 0.0)
    }
}

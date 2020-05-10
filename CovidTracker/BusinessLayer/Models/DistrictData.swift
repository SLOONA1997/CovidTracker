//
//  DistrictData.swift
//  CovidTracker
//
//  Created by Sahil Luna on 25/04/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import Foundation

class DistrictData : DataInfo {
    var districtName:String?
    
    override init(_ rawData: [String : Any]) {
        super.init(rawData)
        if let deathCases = rawData[APIConstants.Keys.deceased] as? String {
            self.deaths = deathCases
        } else if let deathCases = rawData[APIConstants.Keys.deceased] as? Int {
            self.deaths = String.init(deathCases)
        }
    }
    
    func setDistrictName(name:String) {
        self.districtName = name
    }
}

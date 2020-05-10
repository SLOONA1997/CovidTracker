//
//  StateData.swift
//  CovidTracker
//
//  Created by Sahil Luna on 25/04/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import Foundation

class StateData : DataInfo {
    
    var stateName : String?
    var districts : [DistrictData] = [DistrictData]()
    
    override init(_ stateRawData: [String:Any]) {
        super.init(stateRawData)
        stateName = stateRawData[APIConstants.Keys.state] as? String
        if let distData = stateRawData[APIConstants.Keys.district] as? [String:Any] {
            for (key,value) in distData {
                let distDataObj = DistrictData.init(value as! [String:Any])
                distDataObj.setDistrictName(name: key)
                districts.append(distDataObj)
            }
        }
    }
    
    
}

//
//  OverallData.swift
//  CovidTracker
//
//  Created by Sahil Luna on 25/04/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import Foundation

class OverallData {
    var total : DataInfo?
    var stateWise = [StateData]()
    
    init(_ rawData: [String:Any]) {
        if let totalDataInfo = rawData[APIConstants.Keys.totalValues] as? [String:Any] {
            total = DataInfo.init(totalDataInfo)
        }
        if let stateData = rawData[APIConstants.Keys.stateWise] as? [String:Any] {
            for (_,stateInfo) in stateData {
                stateWise.append(StateData.init(stateInfo as! [String:Any]))
            }
        }
        
    }
}

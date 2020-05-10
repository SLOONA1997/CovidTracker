//
//  DataInfo.swift
//  CovidTracker
//
//  Created by Sahil Luna on 25/04/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import Foundation

class DataInfo {
    var active : String?
    var confirmed : String?
    var deaths : String?
    var recovered : String?
    var lastupdatedtime : String?
    
    init(_ rawData:[String:Any]) {
        if let active = rawData[APIConstants.Keys.active] as? String {
            self.active = active
        } else if let active = rawData[APIConstants.Keys.active] as? Int {
            self.active = String.init(active)
        }
        if let confirmedCases = rawData[APIConstants.Keys.confirmed] as? String {
            self.confirmed = confirmedCases
        } else if let confirmedCases = rawData[APIConstants.Keys.confirmed] as? Int {
            self.confirmed = String.init(confirmedCases)
        }
        if let deathCases = rawData[APIConstants.Keys.deaths] as? String {
            self.deaths = deathCases
        } else if let deathCases = rawData[APIConstants.Keys.deaths] as? Int {
            self.deaths = String.init(deathCases)
        }
        if let recovered = rawData[APIConstants.Keys.recovered] as? String {
            self.recovered = recovered
        } else if let recovered = rawData[APIConstants.Keys.recovered] as? Int {
            self.recovered = String.init(recovered)
        }
        lastupdatedtime = rawData[APIConstants.Keys.lastupdatedtime] as? String
    }
    
    /// to get formatted detail
    func getFormattedInfo() -> String {
        let activeCases = String.init(format: "Active cases: %@",
                                      active ?? "")
        let confirmedCases = String.init(format: "Confirmed cases: %@",
                                      confirmed ?? "")
        let totalDeaths = String.init(format: "Death cases: %@",
                                      deaths ?? "")
        let recoveredCases = String.init(format: "Recovered: %@",
                                         recovered ?? "")
//        let totalDeaths = String.init(format: "Death cases: %@",
//        deaths ?? "")
        return String.init(format: "%@\n%@\n%@\n%@", activeCases,
                           confirmedCases,
                           totalDeaths,
                           recoveredCases)
    }
}

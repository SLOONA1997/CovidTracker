//
//  Constants.swift
//  CovidTracker
//
//  Created by Sahil Luna on 25/04/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import UIKit

let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate

class AppConstants {
    
    struct ControllerIdentifier {
        static let ctStateDistController = "CTStateDistController"
        static let ctMapStatController = "CTMapStatController"
    }
    
    struct DashboardOptionsTitle {
        static let seeOnMap = "See on map"
        static let stateAndDistrict = "State and dist. wise"
    }
    
    struct ScreenTiltes {
        static let indiaStates = "Indian statewise update"
        static let distWise = "%@ districtwise update"
    }
    
    struct FontName {
        static let openSans_Light = "OpenSans-Light"
        static let openSans_Regular = "OpenSans-Regular"
    }
    
}

class APIConstants {
    
    static let baseUrl : String = "https://corona-virus-world-and-india-data.p.rapidapi.com/"
    static let instructionRandomUrl = "https://coronavirus-monitor.p.rapidapi.com/coronavirus/random_masks_usage_instructions.php"
    static let host : String =  "corona-virus-world-and-india-data.p.rapidapi.com"
    static let apiKey = "a83c8cd412msh4be61d15c5e5892p1ec302jsne5cad95e0296"
    
    struct UrlEndPoints {
        static let api_india = "https://corona-virus-world-and-india-data.p.rapidapi.com/api_india"
        static let mapGeoJson = "https://covidtracker-7720e.web.app/geoJSON"
    }
    
    struct HeaderKeys {
        static let x_rapidapi_host = "x-rapidapi-host"
        static let x_rapidapi_key = "x-rapidapi-key"
    }
    
    struct Keys {
        static let active = "active"
        static let confirmed = "confirmed"
        static let deaths = "deaths"
        static let recovered = "recovered"
        static let lastupdatedtime = "lastupdatedtime"
        static let state = "state"
        static let deceased = "deceased"
        static let district = "district"
        static let totalValues = "total_values"
        static let stateWise  = "state_wise"
        static let statusCode = "statusCode"
        static let message = "message"
        static let name = "name"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let geometry  = "geometry"
        static let properties = "properties"
        static let features = "features"
    }
    
    struct StatusCode {
        static let sessionExpired = 440
        static let success        = 1
        static let failed         = 0
    }
}

enum StatOpenFor {
    case state,district
}

//
//  CTStateDistViewModel.swift
//  CovidTracker
//
//  Created by Sahil Luna on 26/04/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import Foundation

class CTStateDistViewModel {
    //MARK:- data
    private var stateName:String = ""
    private var stateInfo = [StateData]()
    private var distInfo = [DistrictData]()
    
    private var openFor: StatOpenFor = .state
    
    /// to configure Data for a paerticular district
    /// - Parameters:
    ///   - stateName: state name
    ///   - distData: district name
    func configureData(stateName:String,distData: [DistrictData]) {
        self.stateName = stateName
        self.distInfo = distData
        openFor = .district
    }
    
    /// to configure data for states
    /// - Parameter statesData: state current info
    func configureData(statesData:[StateData]) {
        self.stateInfo = statesData
        openFor = .state
    }
    
    //MARK:- getter methods
    func getTitle() -> String {
        switch openFor {
        case .state:
            return AppConstants.ScreenTiltes.indiaStates
        case .district:
            return String.init(format: AppConstants.ScreenTiltes.distWise,
                               stateName)
        }
    }
    
    /// to get count of states or distrcits of state
    func getNoOfStateOrDist() -> Int {
        switch openFor {
        case .state:
            return stateInfo.count
        case .district:
            return distInfo.count
        }
    }
    
    /// to get paricular data info depends upon open type
    /// - Parameter index: index of state of district
    func getInfo(at index:Int) -> (title:String,info:String) {
        switch openFor {
        case .state:
            return (stateInfo[index].stateName ?? "No name",
                    stateInfo[index].getFormattedInfo())
        case .district:
            return (distInfo[index].districtName ?? "No name",
                    distInfo[index].getFormattedInfo())
        }
    }
    
    /// to get district data
    /// - Parameter index: index of particular state
    func getDistrictData(for index:Int) -> (stateName:String,distData:[DistrictData]) {
        return (stateInfo[index].stateName ?? "",
                stateInfo[index].districts)
    }
    
    /// to check is open for state
    func isStateMode() -> Bool {
        return openFor == .state
    }
}

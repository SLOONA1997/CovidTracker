//
//  CTDashboardViewModel.swift
//  CovidTracker
//
//  Created by Sahil Luna on 25/04/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import Foundation
import UIKit

protocol CTDashboardViewModelDelegate {
    func statFechedSuccessfully()
    func randomInstructionImageUpdated()
    func errInFetchingStat(error:String)
}

class CTDashboardViewModel {
    
    var overallIndiaStatData: OverallData?
    var feedInstructionImage: UIImage?
    var isfetchingFeed:Bool = false
    
    var feedFetchTimer : Timer?
    
    //delegate
    var delegate: CTDashboardViewModelDelegate?
    
    /// to update overall india stat data
    /// - Parameter statData: stat data of india
    func updateStatData(statData:OverallData) {
        self.overallIndiaStatData = statData
    }
    
    /// to start random feed image fertch timer
    func startRandomFeedFetchTimer() {
        feedFetchTimer = Timer.scheduledTimer(timeInterval: 5,
                                              target: self,
                                              selector: #selector(getRandomInstructionImage),
                                              userInfo: nil,
                                              repeats: true)
    }
    
    /// to stop randomm feed fetch timer
    func stopRandomFeedFetchTimer() {
        feedFetchTimer?.invalidate()
    }
    
    //MARK:- getter methods
    func getNoOfCells() -> Int {
        return 4
    }
    
    /// to get overall updated of india
    func getOverallUpdates() -> (title:String,desc:String) {
        let title = "Latest Updates"
        let desc = overallIndiaStatData?.total?.getFormattedInfo() ?? ""
        return (title,desc)
    }
    
    /// to get options data for a particular index
    /// - Parameter index: index of cell
    func getOptionsData(index:Int) -> DashboardOption? {
        switch index {
        case 1:
            return DashboardOption.init(logo: #imageLiteral(resourceName: "locationOnMap"),
                                 title: AppConstants.DashboardOptionsTitle.seeOnMap)
        case 2:
            return DashboardOption.init(logo: #imageLiteral(resourceName: "search"),
                                 title: AppConstants.DashboardOptionsTitle.stateAndDistrict)
        default:
            return nil
        }
    }
    
    /// to get random feed instruction image
    func getRandomInstructionFeedImage() -> UIImage? {
        return self.feedInstructionImage
    }
    
    /// to get data of states
    func getStatesData() -> [StateData] {
        return overallIndiaStatData?.stateWise ?? [StateData]()
    }
    
    /// to fetch overall india stat data
    func fetchData() {
        APIManager.shared.fetchStatData { (isSuccess, overallData, error) in
            if isSuccess,let overallInfo = overallData {
                self.updateStatData(statData: overallInfo)
                self.delegate?.statFechedSuccessfully()
            } else {
                self.delegate?.errInFetchingStat(error: error ?? "")
            }
        }
    }
    
    /// to get randome feed images
    @objc private func getRandomInstructionImage() {
        if isfetchingFeed {
            return
        }
        isfetchingFeed = true
        APIManager.shared.getRandomInstruction { (isSuccess, feedImage, error) in
            if isSuccess,let feedImage = feedImage {
                self.feedInstructionImage = feedImage
                self.delegate?.randomInstructionImageUpdated()
            }
            self.isfetchingFeed = false
        }
    }
}

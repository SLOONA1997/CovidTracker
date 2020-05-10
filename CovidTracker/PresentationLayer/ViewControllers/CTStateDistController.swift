//
//  CTStateDistController.swift
//  CovidTracker
//
//  Created by Sahil Luna on 26/04/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import UIKit

class CTStateDistController: CTBaseViewController {
    //Outlets
    @IBOutlet weak var titleLbl : UILabel?
    @IBOutlet weak var stateDistInfoCollectionView : UICollectionView?
    
    //View model
    let stateDistVMObj = CTStateDistViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    /// to setup initial UI
    func setupUI() {
        titleLbl?.text = stateDistVMObj.getTitle()
    }

    //MARK:- Actions
    
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension CTStateDistController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stateDistVMObj.getNoOfStateOrDist()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CTDashboardOverallCell.getIdentifier(),
                                                      for: indexPath) as! CTDashboardOverallCell
        let stateDistInfo = stateDistVMObj.getInfo(at: indexPath.row)
        cell.configureCell(title: stateDistInfo.title,
                           desc: stateDistInfo.info)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if stateDistVMObj.isStateMode(),let vc = storyboard?.instantiateViewController(identifier: AppConstants.ControllerIdentifier.ctStateDistController) as? CTStateDistController {
            let districtsData = stateDistVMObj.getDistrictData(for: indexPath.row)
            vc.stateDistVMObj.configureData(stateName: districtsData.stateName,
                                             distData: districtsData.distData)
            self.navigationController?.pushViewController(vc,
                                                          animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize.init(width: width,
                           height: 150)
    }
    
}

//
//  CTDashboardController.swift
//  CovidTracker
//
//  Created by Sahil Luna on 25/04/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import UIKit
import SkeletonView

class CTDashboardController: CTBaseViewController {
    //MARK:- Outlets
    @IBOutlet weak var dashBoardCollectionView : UICollectionView?
    
    //View Model
    let dashboardVMObject = CTDashboardViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    /// to setup
    func setup() {
        dashboardVMObject.delegate = self
        dashboardVMObject.fetchData()
        dashboardVMObject.startRandomFeedFetchTimer()
        let gradient = SkeletonGradient(baseColor: UIColor.silver)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        view.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func openStateWiseUpdateScreen() {
        if let vc = storyboard?.instantiateViewController(identifier: AppConstants.ControllerIdentifier.ctStateDistController) as? CTStateDistController {
            vc.stateDistVMObj.configureData(statesData: dashboardVMObject.getStatesData())
            self.navigationController?.pushViewController(vc,
                                                          animated: true)
        }
    }
    
    func opemMapStatScreen() {
        if let vc = storyboard?.instantiateViewController(identifier: AppConstants.ControllerIdentifier.ctMapStatController) as? CTMapStatController {
            self.navigationController?.pushViewController(vc,
                                                          animated: true)
        }
    }

}

extension CTDashboardController: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,SkeletonCollectionViewDataSource {
    //MARK:- skelton collection view delegates
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dashboardVMObject.getNoOfCells()
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        switch indexPath.row {
        case 0:
           return CTDashboardOverallCell.getIdentifier()
        case 3:
            return CTRandomInstructionFeedCell.getIdentifier()
        default:
            return CTDashboardOptionCell.getIdentifier()
        }
    }
    
    //MARK:- collection view delegates
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return dashboardVMObject.getNoOfCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CTDashboardOverallCell.getIdentifier(),
                                                          for: indexPath) as! CTDashboardOverallCell
            let overallStat = dashboardVMObject.getOverallUpdates()
            cell.configureCell(title: overallStat.title,
                               desc: overallStat.desc)
            return cell
        }
        if indexPath.row == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CTRandomInstructionFeedCell.getIdentifier(),
                                                          for: indexPath) as! CTRandomInstructionFeedCell
            if let image = dashboardVMObject.getRandomInstructionFeedImage() {
            cell.configureCell(image: image)
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CTDashboardOptionCell.getIdentifier(),
                                                      for: indexPath) as! CTDashboardOptionCell
        if let option = dashboardVMObject.getOptionsData(index: indexPath.row) {
            cell.configureCell(option: option)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            opemMapStatScreen()
        case 2:
            openStateWiseUpdateScreen()
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
        let width = Double.init(collectionView.frame.width)
        let height = Double.init(180.0)
            return CGSize.init(width: width,
                               height: height)
        }
        if indexPath.row == 3 {
        let width = Double.init(collectionView.frame.width)
            return CGSize.init(width: width,
                               height: width)
        }
        
        let width = (collectionView.frame.width/2) - 5
        return CGSize.init(width: width,
                           height: width)
    }
    
}

extension CTDashboardController : CTDashboardViewModelDelegate {
    func statFechedSuccessfully() {
        DispatchQueue.main.async {
            self.view.hideSkeleton(reloadDataAfter: true,
                                   transition: .crossDissolve(0.5))
//            self.dashBoardCollectionView?.reloadData()
        }
    }
    func randomInstructionImageUpdated() {
        DispatchQueue.main.async {
            self.dashBoardCollectionView?.reloadItems(at: [IndexPath.init(row: 3,
                                                                          section: 0)])
        }
    }
    func errInFetchingStat(error: String) {
        print(error)
    }
}

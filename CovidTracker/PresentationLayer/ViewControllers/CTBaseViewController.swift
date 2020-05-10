//
//  ViewController.swift
//  CovidTracker
//
//  Created by Sahil Luna on 25/04/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import UIKit
import SVProgressHUD

class CTBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    /// to show loader on map
    func showLoader(status:String?) {
        DispatchQueue.main.async {
            SVProgressHUD.show(withStatus: status)
        }
    }
    
    /// to stop loading animation
    func stopLoader() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
}


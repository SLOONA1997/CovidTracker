//
//  CTDashboardOverallCell.swift
//  CovidTracker
//
//  Created by Sahil Luna on 26/04/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import UIKit

class CTDashboardOverallCell: CTBaseCollectionViewCell {
    //MARK:- Outlets
    @IBOutlet weak var titleLbl: UILabel?
    @IBOutlet weak var descLbl:  UILabel?
    @IBOutlet weak var contenttView:  UIView? {
        didSet {
            contenttView?.layer.cornerRadius = 10
            contenttView?.backgroundColor = UIColor.white
            contenttView?.layer.masksToBounds = true
        }
    }
    
    /// to configure cell
    /// - Parameters:
    ///   - title: title in cell
    ///   - desc: description to show in cell
    func configureCell(title:String,desc:String) {
        self.titleLbl?.text = title
        self.descLbl?.text = desc
    }
}

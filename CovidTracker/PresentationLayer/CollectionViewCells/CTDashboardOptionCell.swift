//
//  CTDashboarOptionCell.swift
//  CovidTracker
//
//  Created by Sahil Luna on 26/04/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import UIKit

class CTDashboardOptionCell: CTBaseCollectionViewCell {
    //MARK:- Outlets
    @IBOutlet weak var logoImgView: UIImageView?
    @IBOutlet weak var titleLbl: UILabel?
    @IBOutlet weak var contenttView:  UIView? {
        didSet {
            contenttView?.layer.cornerRadius = 10
            contenttView?.backgroundColor = UIColor.white
            contenttView?.layer.masksToBounds = true
        }
    }
    
    /// to configure cell
    /// - Parameter option: dash board option object contains logo and title
    func configureCell(option:DashboardOption) {
        logoImgView?.image = option.logo
        titleLbl?.text = option.title
    }
}

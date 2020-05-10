//
//  CTRandomInstructionFeedCell.swift
//  CovidTracker
//
//  Created by Sahil Luna on 26/04/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import UIKit

class CTRandomInstructionFeedCell: CTBaseCollectionViewCell {
    //Outlets
    @IBOutlet weak var feedImageView: UIImageView? {
        didSet {
            feedImageView?.layer.cornerRadius = 10
            feedImageView?.backgroundColor = UIColor.white
            feedImageView?.layer.masksToBounds = true
        }
    }
    
    func configureCell(image:UIImage) {
        feedImageView?.image = image
    }
    
}

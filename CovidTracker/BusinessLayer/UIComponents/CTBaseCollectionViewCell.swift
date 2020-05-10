//
//  CTBaseCollectionViewCell.swift
//  CovidTracker
//
//  Created by Sahil Luna on 26/04/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import UIKit

class CTBaseCollectionViewCell: UICollectionViewCell {
    
    /// to get cell identifier
    static func getIdentifier() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

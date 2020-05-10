//
//  UIImageExtension.swift
//  CovidTracker
//
//  Created by Sahil Luna on 10/05/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import UIKit
extension UIImage {
    
    /// to get resized image to particular width and height
    /// - Parameters:
    ///   - width: width
    ///   - height: height
    func getResizedImage(size:CGSize = CGSize.init(width: 50.0,
                                                   height: 50.0)) -> UIImage?{
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        return resizedImage
    }
}

//
//  WaterSourceAnnotation.swift
//  Water App
//
//  Created by Voicu Narcis on 02/08/2016.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class WaterSourceAnnotation: MKPointAnnotation {
    var image: UIImage?
    var infoButton: UIButton!
    
    func getImageFromBase64String(base64String: NSString) -> UIImage? {
        if let decodedData = NSData(base64EncodedString: base64String as String, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters){
            if let image = UIImage(data: decodedData){
                return image
            }
        }
        return nil
    }
}

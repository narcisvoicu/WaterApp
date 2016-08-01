//
//  Utils.swift
//  Water App
//
//  Created by Voicu Narcis on 01/08/2016.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices


class Utils{
    
    static var base64String: String!
    static var imageData: NSData!
    
    static func addAlert(title title: String, message: String, viewController: UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
    static func addItems(viewController: UIViewController, segueIdentifier: String){
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && DataService.dataService.currentUserRef.authData != nil{
            print("Add items action")
            viewController.performSegueWithIdentifier(segueIdentifier, sender: nil)
        } else {
            let ac = UIAlertController(title: "Alert!", message: "You must be logged in to add an item. Please login", preferredStyle: UIAlertControllerStyle.Alert)
            ac.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            viewController.presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    static func imageToBase64(){
        base64String = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
    }
    
    static func changeAddImageButtonOrigin(addPhotoBtn: UIButton, yOrigin: CGFloat){
        addPhotoBtn.frame.origin.y = yOrigin
    }
    
    func openCamera(viewController: UIViewController){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            let picker = UIImagePickerController()
            //picker.delegate = viewController
            picker.sourceType =
                UIImagePickerControllerSourceType.Camera
            picker.mediaTypes = [kUTTypeImage  as String]
            picker.allowsEditing = true
            viewController.presentViewController(picker, animated: true, completion: nil)
        }
    }
}
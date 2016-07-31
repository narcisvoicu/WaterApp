//
//  AddBottlesViewController.swift
//  Water App
//
//  Created by Narcis Voicu on 3/12/16.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import UIKit
import Firebase
import MobileCoreServices

class AddBottlesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Global variables - Outlets
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var bottleNameTf: UITextField!
    @IBOutlet weak var bottlesImageView: UIImageView!
    
    // MARK: - Global variables - Add photo button (action and outlet)
    
    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBAction func addPhotoAction(sender: UIButton) {
        
        let alert = UIAlertController(title: "Add Image", message: "Choose the source of the image", preferredStyle: UIAlertControllerStyle.ActionSheet)
        alert.addAction(UIAlertAction(title: "Take a photo", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Select image from albums", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.addImages()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - Global variables - Add photo button (action and outlet)
    
    @IBOutlet weak var addBottleBtn: UIButton!
    @IBAction func addBottleAction(sender: UIButton) {
        if bottleNameTf.text == "" || bottlesImageView.image == nil{
            addAlert(title: "Ooops!", message: "Please enter a name or an image for your bottle")
        } else {
            imageToBase64()
            let bottle = Bottles(name: bottleNameTf.text!, image: base64String, addedBy: currentUser)
            let bottleRef = DataService.dataService.rootRef.childByAppendingPath("bottles")
            let bottleNameRef = bottleRef.childByAppendingPath(bottleNameTf.text?.lowercaseString)
            
            bottleNameRef.setValue(bottle.toAnyObject())
            
            addAlert(title: "Success!", message: "You have succesfully added a bottle item.")
        }
    }
    
    // MARK: - Global variables - Others
    
    var imageData: NSData!
    var base64String: NSString!
    var currentUser: String!
    
    // MARK: - Methods - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.dataService.currentUserRef.observeEventType(FEventType.Value, withBlock: { (snapshot) -> Void in
            let user = snapshot.value.objectForKey("email") as! String
            self.currentUser = user
            }) { (error) -> Void in
                print(error.description)
        }

    }
    
    override func viewDidLayoutSubviews() {
        bottlesImageView.hidden = true
        changeAddImageButtonOrigin(156)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Methods - Add alert
   
    func addAlert(title title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - Methods - Images methods
    
    func addImages(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType =
                UIImagePickerControllerSourceType.Camera
            picker.mediaTypes = [kUTTypeImage  as String]
            picker.allowsEditing = true
            presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var newImage: UIImage
        
        if let possibleImage = info[UIImagePickerControllerEditedImage]{
            newImage = possibleImage as! UIImage
        } else if let possibleImage = info[UIImagePickerControllerOriginalImage]{
            newImage = possibleImage as! UIImage
        } else {
            return
        }
               
        if let jpegData = UIImagePNGRepresentation(newImage){
            imageData = jpegData
        }
        
        bottlesImageView.image = newImage
        bottlesImageView.hidden = false
        changeAddImageButtonOrigin(bottlesImageView.frame.origin.y + bottlesImageView.frame.height + 8)
        dismissViewControllerAnimated(true, completion: nil)
    
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imageToBase64(){
        base64String = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
    }
    
    func changeAddImageButtonOrigin(yOrigin: CGFloat){
        addPhotoBtn.frame.origin.y = yOrigin
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}

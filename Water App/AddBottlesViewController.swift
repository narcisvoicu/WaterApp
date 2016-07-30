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

class AddBottlesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Global variables - Outlets
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var bottleNameTf: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        if bottleNameTf.text == "" || bottlesImages.count == 0{
            addAlert(title: "Ooops!", message: "Please enter a name or an image for your bottle")
        } else {
            let bottle = Bottles(name: bottleNameTf.text!, addedBy: currentUser)
            let bottleRef = DataService.dataService.rootRef.childByAppendingPath("bottles")
            let bottleNameRef = bottleRef.childByAppendingPath(bottleNameTf.text?.lowercaseString)
            
            imageToBase64()
            let imageStringRef = ["base64string": base64String]
            let imagesRef = bottleNameRef.childByAppendingPath("images")
            let imageDictionary = ["image": imageStringRef]
            
            bottleNameRef.setValue(bottle.toAnyObject())
            imagesRef.setValue(imageDictionary)
            
            addAlert(title: "Success!", message: "You have succesfully added a bottle item.")
        }
    }
    
    // MARK: - Global variables - Others
    
    var bottlesImages = [BottlesImages]()
    var base64String: NSString!
    var base64StringArray = [NSString]()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Methods - Collection View
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return bottlesImages.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ImagesCell
        
        let images = bottlesImages[indexPath.item]
        
        let path = getDocumentsDirectory().stringByAppendingPathComponent(images.image)
        cell.imageView.image = UIImage(contentsOfFile: path)

        return cell
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
        
        let imageName = NSUUID().UUIDString
        
        let imagePath = getDocumentsDirectory().stringByAppendingPathComponent(imageName)
        
        if let jpegData = UIImageJPEGRepresentation(newImage, 80){
             jpegData.writeToFile(imagePath, atomically: true)
        }
        
        let images = BottlesImages(image: imageName)
        bottlesImages.append(images)
        collectionView.reloadData()
        
        print(bottlesImages)
        
        dismissViewControllerAnimated(true, completion: nil)
    
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
        
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func imageToBase64(){
        for i in 0..<bottlesImages.count{
            let bottleImageString = bottlesImages[i].image
            
            let path = getDocumentsDirectory().stringByAppendingPathComponent(bottleImageString)
            let image = UIImage(contentsOfFile: path)
            
            //let data: NSData = bottleImageString.dataUsingEncoding(NSUTF32StringEncoding)!
            
            let data: NSData = UIImagePNGRepresentation(image!)!
            
            base64String = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
            
            base64StringArray.append(base64String)
            
           
        }
        
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

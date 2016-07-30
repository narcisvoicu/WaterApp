//
//  AddSourcesViewController.swift
//  Water App
//
//  Created by Narcis Voicu on 3/12/16.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import MapKit
import MobileCoreServices

class AddSourcesViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet{
            //scrollView.contentSize.height = 800
        }
    }
    
    
    
    @IBOutlet weak var sourceNameTf: UITextField!
    
    @IBOutlet weak var addImageBtn: UIButton!
    @IBAction func addImageAction(sender: UIButton) {
        
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
    
    @IBOutlet weak var sourceImageView: UIImageView!
    
    @IBOutlet weak var addSourceBtn: UIButton!
    @IBAction func addSourceAction(sender: UIButton) {
        if sourceNameTf.text == "" || sourceImageView.image == nil{
            addAlert(title: "Ooops!", message: "Please enter a name or an image for your bottle")
        } else {
            imageToBase64()
            let source = Sources(name: sourceNameTf.text!, image: base64String, latitude: latitude, longitude: longitude, addedBy: currentUser)
            let sourceRef = DataService.dataService.rootRef.childByAppendingPath("sources")
            let sourceNameRef = sourceRef.childByAppendingPath(sourceNameTf.text?.lowercaseString)
            
            sourceNameRef.setValue(source.toAnyObject())
            //imageToBase64()
//            let imageStringRef = ["base64string": base64String]
//            let imagesRef = bottleNameRef.childByAppendingPath("images")
//            let imageDictionary = ["image": imageStringRef]
            
          //  bottleNameRef.setValue(bottle.toAnyObject())
          //  imagesRef.setValue(imageDictionary)
            
            addAlert(title: "Success!", message: "You have succesfully added a source item.")
        }
    }
    
    // MARK: - Global variables - Others
    
   // var bottlesImages = [BottlesImages]()
    var imageData: NSData!
    var base64String: NSString!
   // var base64StringArray = [NSString]()
    var currentUser: String!
    let locationManager = CLLocationManager()
    var latitude: Double!
    var longitude: Double!
    
    // MARK: - Methods - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DataService.dataService.currentUserRef.observeEventType(FEventType.Value, withBlock: { (snapshot) -> Void in
            let user = snapshot.value.objectForKey("email") as! String
            self.currentUser = user
        }) { (error) -> Void in
            print(error.description)
        }
        
        locationSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Location Delegate Methods
    
    func locationSetup(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        
        latitude = location?.coordinate.latitude
        longitude = location?.coordinate.longitude
        
     //  let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
     //   annotation.coordinate = center
     //   mapView.setRegion(region, animated: true)
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("An error has occured: \(error.localizedDescription)")
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
        //var imageData: NSData
        
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
        
        sourceImageView.image = newImage
        
        
     //   let imageName = NSUUID().UUIDString
      //  let imagePath = getDocumentsDirectory().stringByAppendingPathComponent(imageName)
      //  let images = BottlesImages(image: imageName)
       // bottlesImages.append(images)
       // collectionView.reloadData()
        
      //  print(bottlesImages)
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
//    func getDocumentsDirectory() -> NSString {
//        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
//        let documentsDirectory = paths[0]
//        return documentsDirectory
//    }
    
    
    
    func imageToBase64(){
        
        base64String = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
//        for i in 0..<bottlesImages.count{
//            let bottleImageString = bottlesImages[i].image
//            
//            let path = getDocumentsDirectory().stringByAppendingPathComponent(bottleImageString)
//            let image = UIImage(contentsOfFile: path)
//            
//            //let data: NSData = bottleImageString.dataUsingEncoding(NSUTF32StringEncoding)!
//            
//            let data: NSData = UIImagePNGRepresentation(image!)!
//            
//            base64String = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
//            
//            base64StringArray.append(base64String)
//            
//        }
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

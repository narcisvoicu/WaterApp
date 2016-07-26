//
//  InfoBottlesViewController.swift
//  Water App
//
//  Created by Narcis Voicu on 3/12/16.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import UIKit
import Firebase

class InfoBottlesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: - Global variables - Outlets
    
    @IBOutlet weak var bottleName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Global variables - Add review button (action and outlet)
    
    @IBAction func addReviewAction(sender: UIButton) {
        
        blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        
        alertView = UIView(frame: CGRect(x: self.view.center.x - 130, y: self.view.center.y - 200, width: 260, height: 380))
        alertView.backgroundColor = UIColor.whiteColor()
        alertView.layer.cornerRadius = 10
        alertView.layer.borderWidth = 2
        alertView.layer.borderColor = view.tintColor.CGColor
        
        titleLabel = UILabel(frame: CGRect(x: self.view.center.x - 115, y: self.view.center.y - 190, width: 230, height: 30))
        titleLabel.text = "Enter your review below:"
        
        reviewText = UITextView(frame: CGRect(x: self.view.center.x - 115, y: self.view.center.y - 150, width: 230, height: 100))
        reviewText.layer.borderWidth = 1
        reviewText.layer.borderColor = UIColor.blackColor().CGColor
        
        
        addReviewButton = UIButton(frame: CGRect(x: 0, y: self.view.center.y - 40, width: 100, height: 30))
        addReviewButton.center.x = view.center.x
        addReviewButton.setTitle("Add Review", forState: UIControlState.Normal)
        addReviewButton.addTarget(self, action: #selector(InfoBottlesViewController.addReviewToFirebase), forControlEvents: UIControlEvents.TouchUpInside)
       
        
        showReviewPopup()
    }
    
    // MARK: - Global variables - Others
    
    var alertView: UIView!
    var blurEffect: UIBlurEffect!
    var blurEffectView: UIVisualEffectView!
    var titleLabel: UILabel!
    var reviewText: UITextView!
    var addReviewButton: UIButton!
    var bottleName1 = String()
    var currentUser = String()
    var i = 1
    
    var imageBase64String = String()
    var bottlesImages = [String]()
    
    // MARK: - Methods - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottleName.text = bottleName1
  
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add to Favorites", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(InfoBottlesViewController.addToFavorites))

      
        
//        DataService.dataService.currentUserRef.observeEventType(FEventType.Value, withBlock: { (snapshot) -> Void in
//            let user = snapshot.value.objectForKey("email") as! String
//            self.currentUser = user
//            }) { (error) -> Void in
//                print(error.description)
//        }
        
        let imageBottleRef = DataService.dataService.rootRef.childByAppendingPath("bottles").childByAppendingPath(bottleName.text!.lowercaseString).childByAppendingPath("images").childByAppendingPath("image").childByAppendingPath("base64string")
        

        imageBottleRef.observeEventType(FEventType.Value, withBlock: { snapshot in
            self.imageBase64String = snapshot.value as! String
            self.bottlesImages.append(self.imageBase64String)

            self.collectionView.reloadData()
            
            }) { (error) in
                print(error.description)
        }
     DataService.dataService.rootRef.childByAppendingPath("reviews").childByAppendingPath(bottleName.text?.lowercaseString).observeEventType(FEventType.Value, withBlock: { (snapshot) -> Void in
            for _ in snapshot.children{
                self.i += 1
                print("Print: \(self.i)")
            }
            }) { (error) -> Void in
                print(error.description)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addReviewToFirebase(){
        let review = Reviews(text: "", addedby: currentUser, addedto: (bottleName.text?.lowercaseString)!)
        let reviewRef = DataService.dataService.rootRef.childByAppendingPath("reviews")
        let bottleRevRef = reviewRef.childByAppendingPath(bottleName.text?.lowercaseString).childByAppendingPath("review \(i)")
        bottleRevRef.setValue(review.toAnyObject())
        dismissReviewPopup()
    }
    
    func addToFavorites(){
        print("Added to favorites")
        
        let favoritesRef = DataService.dataService.currentUserRef.childByAppendingPath("favorites")
        let bottleFavorites = favoritesRef.childByAppendingPath("bottles").childByAppendingPath(bottleName.text?.lowercaseString).childByAppendingPath("name")
        bottleFavorites.setValue(bottleName.text)
        addAlert(title: "Success!", message: "You've just added \(bottleName.text!) to your favorites")
        
        // Verifica daca a introdus deja apa la favorite !!!
        
    }
    
    // MARK: - Methods - Collection View
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return bottlesImages.count
       
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RetrieveImageCell", forIndexPath: indexPath) as! ImagesCell
        
        let images = bottlesImages[indexPath.item]
        
        let decodedData = NSData(base64EncodedString: images as String, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        
        let decodedImage = UIImage(data: decodedData!)

        cell.imageView.image = decodedImage
        
        return cell
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    // MARK: - Methods - Add alert
    
    func addAlert(title title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Methods - Popup methods
    
    func uiElementsAlphaZero(){
        blurEffectView.alpha = 0
        alertView.alpha = 0
        titleLabel.alpha = 0
        reviewText.alpha = 0
        addReviewButton.alpha = 0
    }
    
    func uiElementsAlphaOne(){
        blurEffectView.alpha = 1
        alertView.alpha = 1
        titleLabel.alpha = 1
        reviewText.alpha = 1
        addReviewButton.alpha = 1
    }
    
    func uiElementsRemoveFromSuperview(){
        blurEffectView.removeFromSuperview()
        alertView.removeFromSuperview()
        titleLabel.removeFromSuperview()
        reviewText.removeFromSuperview()
        addReviewButton.removeFromSuperview()
    }
    
    func uiElementsAddSubview(){
        view.addSubview(blurEffectView)
        view.addSubview(alertView)
        view.addSubview(titleLabel)
        view.addSubview(reviewText)
        view.addSubview(addReviewButton)
    }
    
    func showReviewPopup(){
        uiElementsAlphaZero()
        uiElementsAddSubview()
        UIView.animateWithDuration(0.5) { () -> Void in
            self.uiElementsAlphaOne()
        }
    }
    
    func dismissReviewPopup(){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.uiElementsAlphaZero()
            
            }) { (Bool) -> Void in
                self.uiElementsRemoveFromSuperview()
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

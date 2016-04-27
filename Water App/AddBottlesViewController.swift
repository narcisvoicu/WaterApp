//
//  AddBottlesViewController.swift
//  Water App
//
//  Created by Narcis Voicu on 3/12/16.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import UIKit
import Firebase

class AddBottlesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var bottleNameTf: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBAction func addPhotoAction(sender: UIButton) {
        
    }
    
    var images: UIImage!
    
    @IBOutlet weak var addBottleBtn: UIButton!
    @IBAction func addBottleAction(sender: UIButton) {
        if bottleNameTf.text == ""{
            
            addAlert(title: "Ooops!", message: "Please enter a name for your bottle")
            
           
        } else {
            let bottle = Bottles(name: bottleNameTf.text!, addedBy: currentUser)
            let bottleRef = DataService.dataService.rootRef.childByAppendingPath("bottles")
            let bottleNameRef = bottleRef.childByAppendingPath(bottleNameTf.text?.lowercaseString)
            bottleNameRef.setValue(bottle.toAnyObject())
            addAlert(title: "Success!", message: "You have succesfully added a bottle item.")
        }
    }
    
    var currentUser: String!
    
    
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
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ImagesCell
        
        return cell
    }
   
    func addAlert(title title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
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

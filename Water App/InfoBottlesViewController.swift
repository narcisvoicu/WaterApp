//
//  InfoBottlesViewController.swift
//  Water App
//
//  Created by Narcis Voicu on 3/12/16.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import UIKit
import Firebase

class InfoBottlesViewController: UIViewController {

    @IBOutlet weak var bottleName: UILabel!
    var bottleName1 = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottleName.text = bottleName1
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add to Favorites", style: UIBarButtonItemStyle.Plain, target: self, action: "addToFavorites")

    }
    
    override func viewWillAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addToFavorites(){
        print("Added to favorites")
        
        let favoritesRef = DataService.dataService.currentUserRef.childByAppendingPath("favorites")
        let bottleFavorites = favoritesRef.childByAppendingPath("bottles").childByAppendingPath(bottleName.text?.lowercaseString).childByAppendingPath("name")
        bottleFavorites.setValue(bottleName.text)
        addAlert(title: "Success!", message: "You've just added \(bottleName.text!) to your favorites")
        
        // Verifica daca a introdus deja apa la favorite !!!
        
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

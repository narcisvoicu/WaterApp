//
//  BottlesViewController.swift
//  Water App
//
//  Created by Narcis Florin Voicu on 01/03/16.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import UIKit

class BottlesViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate {
    
    
    
    
    @IBAction func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addItems")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.endEditing(true)
        return true
    }
    
   
    func addItems(){
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && DataService.dataService.currentUserRef.authData != nil{
            
            print("Add items action")
            performSegueWithIdentifier("addBottle", sender: nil)
            
        } else {
            let ac = UIAlertController(title: "Alert!", message: "You must be logged in to add an item. Please login", preferredStyle: UIAlertControllerStyle.Alert)
            ac.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
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

//
//  BottlesViewController.swift
//  Water App
//
//  Created by Narcis Florin Voicu on 01/03/16.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import UIKit

class BottlesViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    var bottles = [String]()
    var filteredBottles = [String]()
    var showResults = false
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bottles = ["Bucovina", "Dorna", "Perla Harghitei"]
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addItems")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if showResults == true{
            return filteredBottles.count
        } else {
            return bottles.count
        }
    
    }
   
   
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("bottle")!
        
        if showResults == true{
            cell.textLabel?.text = filteredBottles[indexPath.row]
        } else {
            cell.textLabel?.text = bottles[indexPath.row]
        }
        
        
        
        return cell
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

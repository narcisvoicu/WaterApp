//
//  BottlesViewController.swift
//  Water App
//
//  Created by Narcis Florin Voicu on 01/03/16.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import UIKit
import Firebase

class BottlesViewController: UIViewController, UISearchBarDelegate, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource {
    
    var bottleName = [String]()
    //var bottles = [Bottles]()
    var filteredBottles = [String]()
    var showResults = false
    var i: Int = 0
    
    var searchController: UISearchController!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSearchController()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(BottlesViewController.addItems))
        
        let bottleRef = DataService.dataService.rootRef.childByAppendingPath("bottles")
        
        bottleRef.observeEventType(.Value, withBlock: { (snapshot) -> Void in
            
            var newBottles = [String]()
            for item in snapshot.children {
                let bottle = Bottles(snapshot: item as! FDataSnapshot)
                newBottles.append(bottle.name)
            }
            self.bottleName = newBottles
            self.tableView.reloadData()

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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if showResults == true && searchController.searchBar.text != ""{
            return filteredBottles.count
        } else {
            return bottleName.count
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{

        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("bottle")!
        
        if showResults == true && searchController.searchBar.text != ""{
            cell.textLabel?.text = filteredBottles[indexPath.row]
        } else {
            cell.textLabel?.text = bottleName[indexPath.row] as String
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        print(bottleName[indexPath.row])
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
    
    func configureSearchController(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search bottle here..."
        searchController.searchBar.sizeToFit()
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if showResults == false {
            showResults = true
            tableView.reloadData()
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        showResults = false
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        showResults = true
        tableView.reloadData()
    }

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchData = searchController.searchBar.text
        filteredBottles = bottleName.filter({ (bottle) -> Bool in
            return bottle.lowercaseString.containsString((searchData?.lowercaseString)!)
        })
        
        tableView.reloadData()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "bottleDetails"{
            if let infoBottle = segue.destinationViewController as? InfoBottlesViewController{
                if let bottleIndex = tableView.indexPathForSelectedRow?.row {
                    infoBottle.bottleName1 = bottleName[bottleIndex] 
                    
                }
            }
            
        }
    }
    

}

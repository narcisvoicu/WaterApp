//
//  FavoritesViewController.swift
//  Water App
//
//  Created by Narcis Voicu on 3/12/16.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import UIKit
import Firebase

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sourcesTableView: UITableView!
    
    var favorites = [String]()
    var favoriteSources = [String]()
    
    var currentUser: String!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        DataService.dataService.currentUserRef.observeEventType(.Value, withBlock: { (snapshot) -> Void in
            let user = snapshot.value.objectForKey("email")
            self.currentUser = user as! String
            }) { (error) -> Void in
                print(error.description)
        }
        
        let bottleFavoritesRef = DataService.dataService.currentUserRef.childByAppendingPath("favorites").childByAppendingPath("bottles")
        bottleFavoritesRef.observeEventType(FEventType.Value, withBlock: { (snapshot) -> Void in
            
            var newItems = [String]()
            
            for item in snapshot.children{

                let favoriteName = item.value!!["name"] as! String
                
                newItems.append(favoriteName)
                
            }
            
            self.favorites = newItems
            self.tableView.reloadData()
            
            }) { (error) -> Void in
                print(error.description)
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView{
            return favorites.count
        } else {
            return favoriteSources.count
        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        if tableView == tableView{
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
            cell.textLabel?.text = favorites[indexPath.row]
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("sourcesCell")! as UITableViewCell
            cell.textLabel?.text = favoriteSources[indexPath.row]
            
            return cell
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

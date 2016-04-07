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
    
    var favorites = [String]()
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
            
            for item in snapshot.children{

                self.favorites.append(item.value!!["name"] as! String)
                
                print(self.favorites)
                
                //self.favorites.append(favoriteBottles.name)
                
                //print("Favorite bottles: \(self.favorites)")
                
            }
            
            self.tableView.reloadData()
            
            }) { (error) -> Void in
                print(error.description)
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        cell.textLabel?.text = favorites[indexPath.row]
        
        return cell
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

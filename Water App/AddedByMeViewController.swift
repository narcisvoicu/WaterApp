//
//  AddedByMeViewController.swift
//  Water App
//
//  Created by Narcis Voicu on 3/12/16.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import UIKit
import Firebase

class AddedByMeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var currentUser: String!
    var itemsAddedByCurrentUser = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DataService.dataService.currentUserRef.observeEventType(.Value, withBlock: { (snapshot) -> Void in
            let user = snapshot.value.objectForKey("email")
            self.currentUser = user as! String
            }) { (error) -> Void in
                print(error.description)
        }
        
        
        let bottleRef = DataService.dataService.rootRef.childByAppendingPath("bottles")
        
        bottleRef.observeEventType(.Value, withBlock: { (snapshot) -> Void in
            
            
            
            for item in snapshot.children{
                let bottles = Bottles(snapshot: item as! FDataSnapshot)
                let addedByCurrentUser = bottles.addedBy
                if self.currentUser == addedByCurrentUser{
                    self.itemsAddedByCurrentUser.append(bottles.name)
                    
                    print("Items added by current user: \(self.itemsAddedByCurrentUser)")
                    
                } else {
                    self.itemsAddedByCurrentUser = ["None"]
                }
                self.tableView.reloadData()
            }
            
            }) { (error) -> Void in
                print(error.description)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsAddedByCurrentUser.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        cell.textLabel?.text = itemsAddedByCurrentUser[indexPath.row]
        
        return cell
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

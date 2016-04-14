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

    @IBOutlet weak var bottlesTableView: UITableView!
    @IBOutlet weak var sourcesTableView: UITableView!
    
    
    var currentUser: String!
    var itemsAddedByCurrentUser = [String]()
    var sourcesAddedByCurrentUser = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DataService.dataService.currentUserRef.observeEventType(.Value, withBlock: { (snapshot) -> Void in
            let user = snapshot.value.objectForKey("email")
            self.currentUser = user as! String
            }) { (error) -> Void in
                print(error.description)
        }
        
        sourcesTableView.dataSource = self
        sourcesTableView.delegate = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let bottleRef = DataService.dataService.rootRef.childByAppendingPath("bottles")
        
        bottleRef.observeEventType(.Value, withBlock: { (snapshot) -> Void in
            
            var newItems = [String]()
            
            for item in snapshot.children{
           
                let bottles = Bottles(snapshot: item as! FDataSnapshot)
                
                print("Bottles snapshot: \(bottles)")
                
                let addedByCurrentUser = bottles.addedBy
                if self.currentUser == addedByCurrentUser{
                    newItems.append(bottles.name)
                    
                    print("Items added by current user: \(self.itemsAddedByCurrentUser)")
                    
                } else {
                    self.itemsAddedByCurrentUser = ["None"]
                }
      
            }
            
            self.itemsAddedByCurrentUser = newItems
            self.bottlesTableView.reloadData()
            
            }) { (error) -> Void in
                print(error.description)
        }
        
        
            sourcesAddedByCurrentUser = ["None"]
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == sourcesTableView{
            return sourcesAddedByCurrentUser.count
        } else if tableView == bottlesTableView{
            return itemsAddedByCurrentUser.count
        } else {
            return 0
        }

    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell = UITableViewCell()
        
        
        if tableView == sourcesTableView{
            
            cell = tableView.dequeueReusableCellWithIdentifier("sourcesCell")! as UITableViewCell
            
            
            
            
            cell.textLabel?.text = sourcesAddedByCurrentUser[indexPath.row]
            
            return cell
            
        } else if tableView == bottlesTableView {
            
            cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
            
            print("ceva")

            cell.textLabel?.text = itemsAddedByCurrentUser[indexPath.row]
            
        }
        
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

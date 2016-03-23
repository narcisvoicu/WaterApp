//
//  MyAccountViewController.swift
//  Water App
//
//  Created by Narcis Florin Voicu on 01/03/16.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController {

    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var favoritesView: UIView!
    @IBOutlet weak var addedByMeView: UIView!
    @IBAction func segmentedControlAction(sender: UISegmentedControl) {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            favoritesView.hidden = false
            addedByMeView.hidden = true
        } else if segmentedControl.selectedSegmentIndex == 1 {
                favoritesView.hidden = true
                addedByMeView.hidden = false
        }
    }
    
    
    @IBAction func logoutAction(sender: UIButton) {
    
        DataService.dataService.currentUserRef.unauth()
        
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        
//        let lvc = storyboard?.instantiateViewControllerWithIdentifier("NavVC")
//        UIApplication.sharedApplication().keyWindow?.rootViewController = lvc
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoritesView.hidden = false
        addedByMeView.hidden = true
        
        navItem.hidesBackButton = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
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

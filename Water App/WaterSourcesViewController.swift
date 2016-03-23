//
//  SecondViewController.swift
//  Water App
//
//  Created by Narcis Florin Voicu on 01/03/16.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import UIKit
import MapKit

class WaterSourcesViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBAction func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addItems")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        mapView.endEditing(true)
    }
    
    func addItems(){
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && DataService.dataService.currentUserRef.authData != nil {
            
            print("Add items action")
            performSegueWithIdentifier("addSource", sender: nil)
            
        } else {
            let ac = UIAlertController(title: "Alert!", message: "You must be logged in to add an item. Please login", preferredStyle: UIAlertControllerStyle.Alert)
            ac.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }


}


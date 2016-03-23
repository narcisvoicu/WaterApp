//
//  FirstViewController.swift
//  Water App
//
//  Created by Narcis Florin Voicu on 01/03/16.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIBarPositioningDelegate {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(NSUserDefaults.standardUserDefaults().valueForKey("uid"))
       // navItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: nil)
        //navBar.barTintColor = UIColor(red: 0/255, green: 210/255, blue: 255/255, alpha: 1.0)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.TopAttached
    }

}


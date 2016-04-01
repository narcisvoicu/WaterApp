//
//  AddBottlesViewController.swift
//  Water App
//
//  Created by Narcis Voicu on 3/12/16.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import UIKit

class AddBottlesViewController: UIViewController {

    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var bottleNameTf: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBAction func addPhotoAction(sender: UIButton) {
        
    }
    @IBOutlet weak var reviewTv: UITextView!
    @IBOutlet weak var addBottleBtn: UIButton!
    @IBAction func addBottleAction(sender: UIButton) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

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

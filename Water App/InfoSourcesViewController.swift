//
//  InfoSourcesViewController.swift
//  Water App
//
//  Created by Narcis Voicu on 3/12/16.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import UIKit
import Firebase

class InfoSourcesViewController: UIViewController {

    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var sourceImageView: UIImageView!
    var sourceName: String!
    var imageBase64String: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sourceNameLabel.text = sourceName
        
        let imageSourceRef = DataService.dataService.rootRef.childByAppendingPath("sources").childByAppendingPath(sourceNameLabel.text!.lowercaseString).childByAppendingPath("image")
        
        imageSourceRef.observeEventType(FEventType.Value, withBlock: { snapshot in
            self.imageBase64String = snapshot.value as! String
            self.decodeImage()
        }) { (error) in
            print(error.description)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func decodeImage(){
        let decodedData = NSData(base64EncodedString: imageBase64String, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        let decodedImage = UIImage(data: decodedData!)
        sourceImageView.image = decodedImage
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

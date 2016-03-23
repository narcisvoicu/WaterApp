//
//  SignInViewController.swift
//  Water App
//
//  Created by Narcis Florin Voicu on 04/03/16.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var retypePassTf: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBAction func signUpAction(sender: UIButton) {
        
        let name = nameTf.text
        let email = emailTf.text
        let password = passwordTf.text
        let retypePass = retypePassTf.text
        
        if name != "" && email != "" && password != "" && retypePass != ""{
            if password == retypePass{
                DataService.dataService.rootRef.createUser(email, password: password, withValueCompletionBlock: { (error, result) -> Void in
                    if error != nil {
                        self.signUpError(title: "Ooops!", message: "Something went wrong while creating your user. Please try again.")
                    } else {
                        
                        // create new user
                        
                        DataService.dataService.rootRef.authUser(email, password: password, withCompletionBlock: { (err, authData) -> Void in
                            
                            let user = ["provider": authData.provider!, "email": email!, "name": name!]
                            
                            DataService.dataService.createUser(authData.uid, user: user)
                            
                        })
                        
                        // store uid
                        
                        NSUserDefaults.standardUserDefaults().setValue(result["uid"], forKey: "uid")
                        
                        self.performSegueWithIdentifier("CreateAccountSegue", sender: nil)
                    }
                })
            } else {
                signUpError(title: "Ooops!", message: "Your password isn't the same in both fields. Please reinsert your password.")
            }
        } else {
            signUpError(title: "Ooops!", message: "Please complete all the fields.")
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    func signUpError(title title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        ac.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(ac, animated: true, completion: nil)
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

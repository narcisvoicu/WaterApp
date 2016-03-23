//
//  LoginViewController.swift
//  Water App
//
//  Created by Narcis Florin Voicu on 03/03/16.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController{

    @IBOutlet weak var usernameTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    
    var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func loginAction(sender: UIButton) {
        
        let username = usernameTf.text
        let password = passwordTf.text
        
        addActivityIndicator()
        
        if username != "" && password != "" {
            DataService.dataService.rootRef.authUser(username, password: password, withCompletionBlock: { (error, authData) -> Void in
                
                if error == nil {
                    
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    
                    self.performSegueWithIdentifier("LoginSegue", sender: nil)
                    
                    self.removeActivityIndicator()
                } else {
                    print(error)
                    self.loginErrorAlert(title: "Oops!", message: "Verify your username and password.")
                    self.removeActivityIndicator()
                }
                
            })
        } else {
            loginErrorAlert(title: "Oops!", message: "Complete all the fields.")
            self.removeActivityIndicator()
        }
        
    }
    
    @IBAction func forgotPassword(sender: UIButton) {
        
        var sendPassToEmailTf = UITextField()
        sendPassToEmailTf.layer.cornerRadius = 5
        
        let ac = UIAlertController(title: "Forgot Password", message: "Enter your email address below", preferredStyle: UIAlertControllerStyle.Alert)
        
       ac.addTextFieldWithConfigurationHandler(nil)
        
        ac.addAction(UIAlertAction(title: "Send", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            sendPassToEmailTf = ac.textFields![0] as UITextField
            
            
            self.sendPassword()
        }))
        
        
         presentViewController(ac, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && DataService.dataService.currentUserRef.authData != nil{
            performSegueWithIdentifier("LoginSegue", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendPassword() -> Void{
        print("Password sent!")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    func loginErrorAlert(title title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        ac.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
        
    }
    
    func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: view.bounds)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
        activityIndicator = nil
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

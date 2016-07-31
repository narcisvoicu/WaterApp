//
//  DataService.swift
//  Water App
//
//  Created by Narcis Voicu on 3/10/16.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    
    static let dataService = DataService()
    private var ROOT_REF = Firebase(url: "https://water-app.firebaseio.com")
    private var USER_REF = Firebase(url: "https://water-app.firebaseio.com/users")
    private var WATER_ITEMS_REF = Firebase(url: "https://water-app.firebaseio.com/waterItems")
    
    var rootRef: Firebase{
        return ROOT_REF
    }
    
    var userRef: Firebase{
        return USER_REF
    }
    
    var currentUserRef: Firebase{
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
    
        let currentUser = Firebase(url: "\(rootRef)").childByAppendingPath("users").childByAppendingPath(userID)
        
        return currentUser
    }
    
    var waterItemsRef: Firebase{
        return WATER_ITEMS_REF
    }
    
    func createUser(uid: String, user: Dictionary<String, String>){
        userRef.childByAppendingPath(uid).setValue(user)
    }
    
}

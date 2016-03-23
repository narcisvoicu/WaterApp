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
    
    private var SOURCES_DETAILS_REF = Firebase(url: "https://water-app.firebaseio.com/sourcesDetails")
    
    private var BOTTLES_DETAILS_REF = Firebase(url: "https://water-app.firebaseio.com/bottlesDetails")
    
    
    var rootRef: Firebase{
        return ROOT_REF
    }
    
    var userRef: Firebase{
        return USER_REF
    }
    
    var currentUserRef: Firebase{
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        print(userID)
        let currentUser = Firebase(url: "\(rootRef)").childByAppendingPath("users").childByAppendingPath(userID)
        
        return currentUser
    }
    
    var sourcesDetailsRef: Firebase{
        return SOURCES_DETAILS_REF
    }
    
    var bottlesDetailsRef: Firebase{
        return BOTTLES_DETAILS_REF
    }
    
    func createUser(uid: String, user: Dictionary<String, String>){
        userRef.childByAppendingPath(uid).setValue(user)
    }
    
}

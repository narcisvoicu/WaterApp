//
//  WaterItems.swift
//  Water App
//
//  Created by Narcis Florin Voicu on 01/04/16.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import Foundation
import Firebase


class Bottles {
    private var KEY: String!
    private var NAME: String!
    private var IMAGE: NSString!
    private var ADDEDBY: String!
    
    var key: String!{
        return KEY
    }
    
    var name: String!{
        return NAME
    }
    
    var image: NSString!{
        return IMAGE
    }
    
    var addedBy: String!{
        return ADDEDBY
    }
    
    // Used for storing data to database
        
    init(name: String, image: NSString, addedBy: String){
        self.KEY = key
        self.NAME = name
        self.IMAGE = image
        self.ADDEDBY = addedBy
    }
    
    func toAnyObject() -> AnyObject {
        return ["name": name,
                "image": image,
                "addedBy": addedBy]
    }
    
    // Used for retrieving data from database
    
    init(snapshot: FDataSnapshot){
        KEY = snapshot.key
        NAME = snapshot.value["name"] as! String
        ADDEDBY = snapshot.value["addedBy"] as! String
    }
}

class Sources {
    private var KEY: String!
    private var NAME: String!
    private var IMAGE: NSString!
    private var LATITUDE: Double!
    private var LONGITUDE: Double!
    private var LOCATION: String!
    private var ADDEDBY: String!

    var key: String!{
        return KEY
    }
    
    var name: String!{
        return NAME
    }
    
    var image: NSString!{
        return IMAGE
    }
    
    var latitude: Double!{
        return LATITUDE
    }
    
    var longitude: Double!{
        return LONGITUDE
    }
    
    var location: String!{
        return LOCATION
    }
    
    var addedBy: String!{
        return ADDEDBY
    }
    
    init(name: String, image: NSString, latitude: Double, longitude: Double, location: String, addedBy: String){
        self.NAME = name
        self.IMAGE = image
        self.LATITUDE = latitude
        self.LONGITUDE = longitude
        self.LOCATION = location
        self.ADDEDBY = addedBy
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "name": name,
            "image": image,
            "latitude": latitude,
            "longitude": longitude,
            "location": location,
            "addedBy": addedBy,
        ]
    }
    
    init(snapshot: FDataSnapshot){
        KEY = snapshot.key
        NAME = snapshot.value["name"] as! String
        IMAGE = snapshot.value["image"] as! NSString
        LATITUDE = snapshot.value["latitude"] as! Double
        LONGITUDE = snapshot.value["longitude"] as! Double
        LOCATION = snapshot.value["location"] as! String
        ADDEDBY = snapshot.value["addedBy"] as! String
    }
}


class Reviews {
    private var KEY: String!
    private var TEXT: String!
    private var ADDEDBY: String!
    private var ADDEDTO: String!
    
    var key: String!{
        return KEY
    }
    
    var text: String!{
        return TEXT
    }
    
    var addedby: String!{
        return ADDEDBY
    }
    
    var addedto: String!{
        return ADDEDTO
    }
    
    init(text: String, addedby: String, addedto: String){
        self.TEXT = text
        self.ADDEDBY = addedby
        self.ADDEDTO = addedto
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "text": text,
            "addedBy": addedby,
            "addedTo": addedto
        ]
    }
    
    init(snapshot: FDataSnapshot){
        KEY = snapshot.key
        TEXT = snapshot.value["text"] as! String
        ADDEDBY = snapshot.value["addedBy"] as! String
        ADDEDTO = snapshot.value["addedTo"] as! String
    }
}
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
    private var IMAGE: UIImage!
    private var ADDEDBY: String!
    
    var key: String!{
        return KEY
    }
    
    var name: String!{
        return NAME
    }
    
    var image: UIImage!{
        return IMAGE
    }
    
    var addedBy: String!{
        return ADDEDBY
    }
    
    // Used for storing data to database
        
    init(name: String, addedBy: String){
        self.KEY = key
        self.NAME = name
        self.ADDEDBY = addedBy
    }
    
    // Used for retrieving data from database
    
    init(snapshot: FDataSnapshot){
        KEY = snapshot.key
        NAME = snapshot.value["name"] as! String
        ADDEDBY = snapshot.value["addedBy"] as! String
    }
    
    func toAnyObject() -> AnyObject {
        return ["name": name,
                "addedBy": addedBy]
    }
    
}

class Sources {
    private var KEY: String!
    private var NAME: String!
    private var IMAGE: UIImage!
    private var LATITUDE: String!
    private var LONGITUDE: String!

    var key: String!{
        return KEY
    }
    
    var name: String!{
        return NAME
    }
    
    var image: UIImage!{
        return IMAGE
    }
    
    var latitude: String!{
        return LATITUDE
    }
    
    var longitude: String!{
        return LONGITUDE
    }
    
    init(name: String, image: UIImage, latitude: String, longitude: String){
        self.NAME = name
        self.IMAGE = image
        self.LATITUDE = latitude
        self.LONGITUDE = longitude
    }
    
    init(snapshot: FDataSnapshot){
        KEY = snapshot.key
        NAME = snapshot.value["name"] as! String
        IMAGE = snapshot.value["image"] as! UIImage
        LATITUDE = snapshot.value["latitude"] as! String
        LONGITUDE = snapshot.value["longitude"] as! String
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "name": name,
            "image": image,
            "latitude": latitude,
            "longitude": longitude,
            
        ]
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
    
    init(snapshot: FDataSnapshot){
        KEY = snapshot.key
        TEXT = snapshot.value["text"] as! String
        ADDEDBY = snapshot.value["addedBy"] as! String
        ADDEDTO = snapshot.value["addedTo"] as! String
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "text": text,
            "addedBy": addedby,
            "addedTo": addedto
        ]
    }
    
}
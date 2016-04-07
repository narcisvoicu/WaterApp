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
    
//    init(name: String, image: UIImage){
//        self.KEY = key
//        self.NAME = name
//        self.IMAGE = image
//    }
    
    init(name: String, addedBy: String){
        self.KEY = key
        self.NAME = name
        self.ADDEDBY = addedBy
    }
    
    // Used for retrieving data from database
    
//    init(snapshot: FDataSnapshot){
//        KEY = snapshot.key
//        NAME = snapshot.value["name"] as! String
//        IMAGE = snapshot.value["image"] as! UIImage
//    }
    
    init(snapshot: FDataSnapshot){
        KEY = snapshot.key
        NAME = snapshot.value["name"] as! String
        ADDEDBY = snapshot.value["addedBy"] as! String
    }
    
//    func toAnyObject() -> AnyObject {
//        return [
//            "name": name,
//            "image": image,
//            
//        ]
//    }
    
    func toAnyObject() -> AnyObject {
        return ["name": name,
                "addedBy": addedBy]
    }
    
}

class Sources {
    private var KEY: String!
    private var NAME: String!
    private var IMAGE: UIImage!

    var key: String!{
        return KEY
    }
    
    var name: String!{
        return NAME
    }
    
    var image: UIImage!{
        return IMAGE
    }
    
    init(key: String, name: String, image: UIImage){
        self.KEY = key
        self.NAME = name
        self.IMAGE = image
    }
    
    init(snapshot: FDataSnapshot){
        KEY = snapshot.key
        NAME = snapshot.value["name"] as! String
        IMAGE = snapshot.value["image"] as! UIImage
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "name": name,
            "image": image,
            
        ]
    }
    
}


class Reviews {
    private var KEY: String!
    private var TEXT: String!
    private var ADDEDBY: String!
    
    var key: String!{
        return KEY
    }
    
    var text: String!{
        return TEXT
    }
    
    var addedby: String!{
        return ADDEDBY
    }
    
    init(key: String, text: String, addedby: String){
        self.KEY = key
        self.TEXT = text
        self.ADDEDBY = addedby
    }
    
    init(snapshot: FDataSnapshot){
        KEY = snapshot.key
        TEXT = snapshot.value["text"] as! String
        ADDEDBY = snapshot.value["addedBy"] as! String
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "text": text,
            "addedBy": addedby,
        ]
    }
    
}
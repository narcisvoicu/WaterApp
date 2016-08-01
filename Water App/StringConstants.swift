//
//  StringConstants.swift
//  Water App
//
//  Created by Voicu Narcis on 01/08/2016.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import Foundation

struct StringConstants {
    
    struct RequestLoginAlert {
        static let okButton = "OK"
        static let alertTitle = "Alert!"
        static let requestLogin = "You must be logged in to add an item. Please login"
    }
    
    struct AddPhotoActionSheet {
        static let actionSheetTitle = "Add Image"
        static let actionSheetMessage = "Choose the source of the image"
        static let takePhoto = "Take a photo"
        static let openGallery = "Select image from albums"
        static let cancel = "Cancel"
    }
    
    struct addItemsAlert {
        static let alertTitle = "Ooops!"
        static let successTitle = "Success!"
    }
    
    struct AddBottleAlert {
        static let alertMessage = "Please enter a name or an image for your bottle"
        static let successMessage = "You have succesfully added a bottle item."
    }
    
    struct AddSourceAlert {
        static let alertMessage = "Please enter a name or an image for your source"
        static let successMessage = "You have succesfully added a source item."
    }
    
    
}
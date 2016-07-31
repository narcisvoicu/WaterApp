//
//  SecondViewController.swift
//  Water App
//
//  Created by Narcis Florin Voicu on 01/03/16.
//  Copyright © 2016 Advahoo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class WaterSourcesViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
        {
        didSet{
            mapView.delegate = self
        }
    }

    var sources: [Sources]!
    
    @IBAction func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(WaterSourcesViewController.addItems))
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let sourceRef = DataService.dataService.rootRef.childByAppendingPath("sources")
        sourceRef.observeEventType(.Value, withBlock: { (snapshot) -> Void in
            var newSources = [Sources]()
            for item in snapshot.children {
                let source = Sources(snapshot: item as! FDataSnapshot)
                newSources.append(source)
            }
            self.sources = newSources
            self.setupAnnotations()
            print("Sources: \(self.sources)")
        }) { (error) -> Void in
            print(error.description)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        mapView.endEditing(true)
    }
    
    
    func addItems(){
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && DataService.dataService.currentUserRef.authData != nil {
            performSegueWithIdentifier("addSource", sender: nil)
        } else {
            let ac = UIAlertController(title: "Alert!", message: "You must be logged in to add an item. Please login", preferredStyle: UIAlertControllerStyle.Alert)
            ac.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        print("viewForAnnotation")
        return nil
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        print("didSelectAnnotationView")
    }
    
    
    func setupAnnotations(){
        var allAnnotations = [MKPointAnnotation]()
        for i in 0 ..< sources.count{
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: sources[i].latitude, longitude: sources[i].longitude)
            annotation.title = sources[i].name
            print("Annotation: \(annotation)")
            print("Annotation latitude: \(annotation.coordinate.latitude)")
            mapView.addAnnotation(annotation)
            allAnnotations.append(annotation)
            
        }
        mapView.showAnnotations(allAnnotations, animated: true)
    }

}


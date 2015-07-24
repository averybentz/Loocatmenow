//
//  ViewController.swift
//  Loocatmenow
//
//  Created by Avery Bentz on 2015-07-24.
//  Copyright (c) 2015 Avery Bentz. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet var MapView: MKMapView!
    
    //Create CLLocationManager obj
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
    CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
        
        if (error != nil){
            println("Error" + error.localizedDescription)
            return
        }
        
        if (placemarks.count > 0 ){
            let pm = placemarks[0] as! CLPlacemark
            self.displayLocationInfo(pm)
        }
        
        else{
            println("Error with data")
        }
    })
    }

    func displayLocationInfo(placemark: CLPlacemark){
        
        //Stop updating the location
        self.locationManager.stopUpdatingLocation()
        //println(placemark.addressDictionary)
        println(placemark.locality)
        println(placemark.postalCode)
        println(placemark.administrativeArea)
        println(placemark.country)
    }
    
    func locationManager (manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        //Print error
        println("Error" + error.localizedDescription)
    }
    
    
    
    
    //Function to display location on MapView
    func displayLocationOnMap(placemark: CLPlacemark){
        
        
    }

}


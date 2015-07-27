//
//  ViewController.swift
//  Loocatmenow
//
//  Created by Avery Bentz on 2015-07-24.
//  Copyright (c) 2015 Avery Bentz. All rights reserved.
//

import UIKit
//import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet var MapView: MKMapView!
    @IBOutlet var locationInfo: UILabel!
    
    //Create CLLocationManager obj
    var coreLocationManager = CLLocationManager()
    //Create LocationManager instance
    var locationManager: LocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib./Users/averybentz/Downloads/LocationManager-master/LocationManager.swift
        
        coreLocationManager.delegate = self
        
        locationManager = LocationManager.sharedInstance
        
        /*self.coreLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.coreLocationManager.requestWhenInUseAuthorization()
        self.coreLocationManager.startUpdatingLocation()*/
        
        getLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
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
    }*/
    
    /*func displayLocationInfo(placemark: CLPlacemark){
        
        //Stop updating the location
        self.coreLocationManager.stopUpdatingLocation()
        //println(placemark.addressDictionary)
        println(placemark.locality)
        println(placemark.postalCode)
        println(placemark.administrativeArea)
        println(placemark.country)
    }
    
    func locationManager (manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        //Print error
        println("Error" + error.localizedDescription)
    }*/
    
    
    func getLocation(){
        
        locationManager.startUpdatingLocationWithCompletionHandler { (latitude, longitude, status, verboseMessage, error) -> () in
            
            self.displayLocation(CLLocation(latitude: latitude, longitude: longitude))
            
        }
    }
    
    func displayLocation(location: CLLocation){
        
        //Set region of the map
        MapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude), span: MKCoordinateSpanMake(0.05, 0.05)), animated: true)
        
        let locationPinCoord = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationPinCoord
        
        MapView.addAnnotation(annotation)
        MapView.showAnnotations([annotation], animated: true)
        
        locationManager.reverseGeocodeLocationWithCoordinates(location, onReverseGeocodingCompletionHandler: { (reverseGecodeInfo, placemark, error) -> Void in
        
            let address = reverseGecodeInfo?.objectForKey("formattedAddress") as! String
            self.locationInfo.text = address
        })
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status != CLAuthorizationStatus.NotDetermined || status != CLAuthorizationStatus.Denied || status != CLAuthorizationStatus.Restricted{
            // Get location
            getLocation()
        }
    }
    @IBAction func updateLocation(sender: AnyObject) {
        
        self.getLocation()
    }
    
}




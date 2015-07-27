//
//  ViewController.swift
//  Loocatmenow
//
//  Created by Avery Bentz on 2015-07-24.
//  Copyright (c) 2015 Avery Bentz. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    //Create CLLocationManager obj
    var coreLocationManager = CLLocationManager()

    var locationManager: LocationManager!
    
    @IBOutlet var MapView: MKMapView!
    @IBOutlet var locationInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib./Users/averybentz/Downloads/LocationManager-master/LocationManager.swift
        
        coreLocationManager.delegate = self
        
        //Create LocationManager
        locationManager = LocationManager.sharedInstance
        
        getLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getLocation(){
        
        locationManager.startUpdatingLocationWithCompletionHandler { (latitude, longitude, status, verboseMessage, error) -> () in
            
            self.displayLocation(CLLocation(latitude: latitude, longitude: longitude))
            
        }
        //locationManager.startUpdatingLocation()
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
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        let location = [locations].last
        println(location)
    }
    
    @IBAction func updateLocation(sender: AnyObject) {
        
        self.getLocation()
    }
    
}




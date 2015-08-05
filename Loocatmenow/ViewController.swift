//
//  ViewController.swift
//  Loocatmenow
//
//  Created by Avery Bentz on 2015-07-24.
//  Copyright (c) 2015 Avery Bentz. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    //Create CLLocationManager obj
    var coreLocationManager = CLLocationManager()
    
    @IBOutlet var MapView: MKMapView!
    @IBOutlet var locationInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib./Users/averybentz/Downloads/LocationManager-master/LocationManager.swift
        
        coreLocationManager.delegate = self
        coreLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        coreLocationManager.requestWhenInUseAuthorization()
        coreLocationManager.startUpdatingLocation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var userLocation:CLLocation = locations[0] as! CLLocation
        
        //Stop updating location now that we have it
        coreLocationManager.stopUpdatingLocation()
        
        let location = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        
        let region = MKCoordinateRegionMake(location, span)
        
        MapView.setRegion(region, animated: true)
        
        //println(coreLocationManager.location.description)
        
        //Get address of the current location
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        println(error)
    
    }
    
    //User taps "Uppdate" button
    @IBAction func updateLocation(sender: AnyObject) {
        
        //Start updating location again
        coreLocationManager.startUpdatingLocation()
    }
}

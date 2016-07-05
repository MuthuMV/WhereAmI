//
//  ViewController.swift
//  mapView
//
//  Created by Muthu Venkatesh on 5/19/16.
//  Copyright © 2016 Muthu Venkatesh. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
//    @IBAction func whereAmI(sender: AnyObject) {
//        
////        print("Inside click... \(String(userLocation.coordinate.latitude)) \(String(userLocation.coordinate.longitude))")
////        let whereAmI : ViewController = storyboard?.instantiateViewControllerWithIdentifier("whereAmI") as! ViewController
////        whereAmI.location.text = "Latitude:\(String(userLocation.coordinate.latitude)) Longitude: \(String(userLocation.coordinate.longitude))"
////        navigationController?.pushViewController(whereAmI, animated: true)
//
////        location.text = "Latitude:\(String(userLocation.coordinate.latitude)) Longitude: \(String(userLocation.coordinate.longitude))"
//////        address.text =
////        speed.text = "\(String(userLocation.speed)) MPS"
////        altitude.text = "\(String(userLocation.altitude))"
//    }
    
    var manager = CLLocationManager()
    var annotation = MKPointAnnotation()
    var userLocation = CLLocation()
    var geoCoder = CLGeocoder()
    var userAddress = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        userLocation = locations[0]
        print(userLocation)
//        print(userLocation.coordinate.latitude)
//        print(userLocation.coordinate.longitude)
//        print(userLocation.speed)

        let latitude : CLLocationDegrees = userLocation.coordinate.latitude
        let longitude : CLLocationDegrees = userLocation.coordinate.longitude
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let latitudeDelta : CLLocationDegrees = 0.05
        let longitudeDelta : CLLocationDegrees = 0.05
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longitudeDelta)
        
        let region : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        if let map = map {
            print("Inside optional binding")
            map.setRegion(region, animated: true)
            
            annotation.coordinate = location
            annotation.title = "Your assssssss"
            annotation.subtitle = "Gotchaaaa..."
            map.addAnnotation(annotation)
            print("End of manager...")
        }
        reverseGeoCoding()
        
    }
    
    func reverseGeoCoding (){
        
        geoCoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            
            if let error = error {
                print("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if let placemarks = placemarks where placemarks.count > 0 {
                let pm : CLPlacemark = placemarks[0]
                
                //can get different parts of the address using diff attributes.
                if let locality = pm.locality {
                    self.userAddress = locality
                }
            }
            else {
                print("Problem with the data received from geocoder")
            }
        
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "whereAmI") {
            
            let segueController : WhereAmIViewController = segue.destinationViewController as! WhereAmIViewController
            print("In prepareforsegue... ")
            segueController.locationDetails = self
            
        }
    }
    
    @IBAction func unwindToMap(segue: UIStoryboardSegue) {
        
    }
    
    
}


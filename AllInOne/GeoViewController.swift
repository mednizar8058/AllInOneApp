//
//  GeoViewController.swift
//  AllInOne
//
//  Created by MNizar on 6/21/21.
//  Copyright © 2021 MNizar. All rights reserved.
//

import UIKit
import MapKit

class GeoViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longtitude: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var vAccuracy: UILabel!
    @IBOutlet weak var hAccuracy: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var mkMapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var startLocation:CLLocation!
    var startLocation1:CLLocation!
    var annotation = MKPointAnnotation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        startLocation = nil
        mkMapView.delegate = self
        
        //gesture
        let press = UILongPressGestureRecognizer(target: self, action: #selector(action(gesture:)))
        press.minimumPressDuration = 0.5
        mkMapView.addGestureRecognizer(press)
        
        mkMapView.layer.cornerRadius = 20
        dataView.layer.cornerRadius = 30
        

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func refresh(_ sender: Any) {
        startLocation = nil
    }
    
    @objc func action(gesture: UIGestureRecognizer){
        let touchPoint = gesture.location(in: self.mkMapView)
        let newCoordinates:CLLocationCoordinate2D = mkMapView.convert(touchPoint, toCoordinateFrom: self.mkMapView)
        
        let anno = MKPointAnnotation()
        anno.coordinate = newCoordinates
        anno.title = "here"
        anno.subtitle = "sub"
        mkMapView.addAnnotation(anno)
        
        
        
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latestLocation:CLLocation = locations[locations.count - 1]
        latitude.text = String(format:"%.4f", latestLocation.coordinate.latitude)
        longtitude.text = String(format:"%.4f", latestLocation.coordinate.longitude)
        vAccuracy.text = String(format:"%.4f", latestLocation.verticalAccuracy)
        hAccuracy.text = String(format:"%.4f", latestLocation.horizontalAccuracy)
        altitude.text = String(format:"%.4f", latestLocation.altitude)
        
        let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let loc:CLLocationCoordinate2D = CLLocationCoordinate2DMake(32.992424 ,-7.622266 )
        let region:MKCoordinateRegion = MKCoordinateRegion.init(center: loc, span: span)
        
        CLGeocoder().reverseGeocodeLocation(latestLocation){
            (mar,err) in
            if let place = mar?[0]{
                self.label.text = "\(place.thoroughfare!),\(place.subLocality!),\(place.subAdministrativeArea!),\(place.postalCode!),\(place.country!)"
            }
        }
        
        annotation.coordinate = latestLocation.coordinate
        annotation.title = "I'm here"
        annotation.subtitle = "Med Nizar"
        mkMapView.addAnnotation(annotation)
        mkMapView.setRegion(region, animated: true)
        mkMapView.showsUserLocation = true
        
        if startLocation == nil{
            startLocation = latestLocation
            startLocation1 = locations[0]
            
        }
        
        let distanceBetween:CLLocationDistance = latestLocation.distance(from: startLocation)
        
        let distanceBetween1:CLLocationDistance = latestLocation.distance(from: startLocation1)
        
        distance.text = String(format:"%.4f", distanceBetween)
        label.text = String(format:"%.4f", distanceBetween1)
        
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

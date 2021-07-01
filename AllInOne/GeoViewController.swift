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
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longtitude: UILabel!
    @IBOutlet weak var bd: UILabel!
    @IBOutlet weak var codePostalCity: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var mkMapView: MKMapView!
    
    @IBOutlet weak var distBtnn: UIButton!
    
    var latestLocation:CLLocation = CLLocation()
    var locationManager = CLLocationManager()
    var startLocation:CLLocation!
    var annotation = MKPointAnnotation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //hide distbtn
        distance.isHidden = true
        distBtnn.isHidden = true
        
        //locationManager
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        startLocation = nil
        //mkMapView.delegate = self
        
        //search bar
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        //distBtnn
        distBtnn.layer.cornerRadius = 10
        
        //baackground gradiant
        let gradiantLayer = CAGradientLayer()
        gradiantLayer.frame = view.bounds
        gradiantLayer.colors = [UIColor.systemBlue.cgColor,UIColor.white.cgColor]
        view.layer.insertSublayer(gradiantLayer, at: 0)
        
        //gesture
        let press = UILongPressGestureRecognizer(target: self, action: #selector(action(gesture:)))
        press.minimumPressDuration = 0.5
        mkMapView.addGestureRecognizer(press)
        
        mkMapView.layer.cornerRadius = 30
        dataView.layer.cornerRadius = 17
        

    }
    
    @IBAction func searchLocation(_ sender: UIButton){
        //ignoring user
        //mkMapView.isUserInteractionEnabled = false
        distance.isHidden = true
        
        //create search request
        let searchRequeest = MKLocalSearch.Request()
        searchRequeest.naturalLanguageQuery = searchBar.text!
        let activeSearch = MKLocalSearch(request: searchRequeest)
        activeSearch.start{ (res,err) in
            if res == nil{
                let alert = UIAlertController(title: "MapKit", message: "Wrong city name!", preferredStyle: .alert)
                let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true)
                
            }
            else{
                //remove all anotations :
                self.mkMapView.removeAnnotations(self.mkMapView.annotations)

                //get latitude and longitude
                let lat = res!.boundingRegion.center.latitude
                let long = res!.boundingRegion.center.longitude
                
                //create location:
                let newLocation = CLLocation(latitude: lat, longitude: long)
                CLGeocoder().reverseGeocodeLocation(newLocation){
                (mar,err) in
                if let place = mar?[0]{
                    self.bd.text = "\(place.thoroughfare ?? "")"
                    self.codePostalCity.text = "\(place.postalCode ?? "") \(place.locality ?? "")"
                    self.country.text = place.country
                    }
                }
                
                //create annotation
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2DMake(lat, long)
                annotation.title = self.searchBar.text!
                self.mkMapView.addAnnotation(annotation)
                //zoom in in annotation
                let coordiante = annotation.coordinate
                let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
                let region = MKCoordinateRegion(center: coordiante, span: span)
                self.mkMapView.setRegion(region, animated: true)
                self.latitude.text = String(format: "%.4f",lat)
                self.longtitude.text = String(format: "%.4f",long)
                
                //calculate distance:
                self.calculateDistance(latestLocation: self.latestLocation, newLocation: newLocation)
                self.distBtnn.isHidden = false

                
                
                
                
            }
        }
    }
    
    
    
    @IBAction func resetPosition(_ sender: Any) {
        self.mkMapView.removeAnnotations(self.mkMapView.annotations)
        distBtnn.isHidden = true
        distance.isHidden = true
        latitude.text = String(format:"%.4f", latestLocation.coordinate.latitude)
        longtitude.text = String(format:"%.4f", latestLocation.coordinate.longitude)
        
        
        let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let loc:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latestLocation.coordinate.latitude, latestLocation.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion.init(center: loc, span: span)
        mkMapView.setRegion(region, animated: true)
        
        CLGeocoder().reverseGeocodeLocation(latestLocation){
            (mar,err) in
            if let place = mar?[0]{
                self.bd.text = place.thoroughfare!
                self.codePostalCity.text = "\(place.postalCode!) \(place.locality!)"
                self.country.text = place.country
                self.searchBar.text = ""
                self.distance.text = ""
            }
        }
        
    }
    
    @objc func action(gesture: UIGestureRecognizer){
        distance.isHidden = true
        //remove all annotations
        self.mkMapView.removeAnnotations(self.mkMapView.annotations)
        let touchPoint = gesture.location(in: self.mkMapView)
        let newCoordinates:CLLocationCoordinate2D = mkMapView.convert(touchPoint, toCoordinateFrom: self.mkMapView)
        
        let newLocation = CLLocation(latitude: newCoordinates.latitude, longitude: newCoordinates.longitude)
        
        CLGeocoder().reverseGeocodeLocation(newLocation){
        (mar,err) in
        if let place = mar?[0]{
            self.bd.text = "\(place.thoroughfare ?? "")"
            self.codePostalCity.text = "\(place.postalCode ?? "") \(place.locality ?? "")"
            self.country.text = place.country
            let anno = MKPointAnnotation()
            anno.coordinate = newCoordinates
            anno.title = "\(place.thoroughfare ?? "\(place.locality!)")"
            anno.subtitle = "\(place.country!)"
            self.mkMapView.addAnnotation(anno)
            }
        }
        
        //calculate the distance
        calculateDistance(latestLocation: latestLocation, newLocation: newLocation)
        distBtnn.isHidden = false
       
    }
    
    func calculateDistance(latestLocation:CLLocation, newLocation:CLLocation){
        distance.text = String(format: "%.4f",latestLocation.distance(from: newLocation))
    }
    
    
    @IBAction func didTapDistance(_ sender: Any) {
        distance.isHidden = false
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        latestLocation = locations[locations.count - 1]
        latitude.text = String(format:"%.4f", latestLocation.coordinate.latitude)
        longtitude.text = String(format:"%.4f", latestLocation.coordinate.longitude)
        
        
        let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let loc:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latestLocation.coordinate.latitude, latestLocation.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion.init(center: loc, span: span)
        mkMapView.setRegion(region, animated: true)
        
        CLGeocoder().reverseGeocodeLocation(latestLocation){
            (mar,err) in
            if let place = mar?[0]{
                self.bd.text = place.thoroughfare!
                self.codePostalCity.text = "\(place.postalCode!) \(place.locality!)"
                self.country.text = place.country
                
                //self.label.text = "\(place.thoroughfare ?? "throughfare"),\(place.subLocality ?? "sublocality"), \n\(place.subAdministrativeArea ?? "subAdminarea"),\(place.postalCode ?? "postalCode"),\(place.country ?? "country")"
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
            
        }
        
        //let distanceBetween:CLLocationDistance = latestLocation.distance(from: startLocation)
        
       // let distanceBetween1:CLLocationDistance = latestLocation.distance(from: startLocation1)
        
        
        //label.text = String(format:"%.4f", distanceBetween1)
        
        
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

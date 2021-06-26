//
//  GeoViewController.swift
//  AllInOne
//
//  Created by MNizar on 6/21/21.
//  Copyright © 2021 MNizar. All rights reserved.
//

import UIKit
import MapKit

class GeoViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mkMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mkMapView.layer.cornerRadius = 20

        // Do any additional setup after loading the view.
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

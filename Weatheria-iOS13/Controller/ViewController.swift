//
//  ViewController.swift
//  Weatheria-iOS13
//
//  Created by DDD on 05/05/20.
//  Copyright © 2020 Dandun Adi. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    
    let weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }

    @IBAction func locationButtonPressed(_ sender: UIButton) {
        // Get weather data based on current user's location
        locationManager.requestLocation()
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        // Get weather data from searchTextField
    }
    
}

//MARK: - Core Location Delegate

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            weatherManager.fetchURL(lat: latitude, lon: longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

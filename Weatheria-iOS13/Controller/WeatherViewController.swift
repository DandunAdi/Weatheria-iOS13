//
//  ViewController.swift
//  Weatheria-iOS13
//
//  Created by DDD on 05/05/20.
//  Copyright © 2020 Dandun Adi. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        locationManager.delegate = self
        searchTextField.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        temperatureLabel.text = "-"
        cityName.text = "Loading.."
        
        self.dismissKey()
        
    }

    @IBAction func locationButtonPressed(_ sender: UIButton) {
        // Get weather data based on current user's location
        locationManager.requestLocation()
    }
    
}

//MARK: - Core Location Delegate

extension WeatherViewController: CLLocationManagerDelegate {
    
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


//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weatherModel: WeatherModel) {
        
        DispatchQueue.main.async {
            self.temperatureLabel.text = weatherModel.temperatureString
            self.cityName.text = weatherModel.cityName
            self.weatherIcon.image = UIImage(systemName: weatherModel.weatherIconData)
        }
        
    }
    
    func didError(_ error: Error) {
        print(error)
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Stop fetching data if user didn't type anyting in searchTextField
        guard searchTextField.text != "" else {
            return
        }
        
        if var cityName = searchTextField.text {
            //API url can't fetch data from city that contain spaces
            cityName = cityName.replacingOccurrences(of: " ", with: "+")
            
            weatherManager.fetchURL(by: cityName)
        }
        searchTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        searchTextField.endEditing(true)
    }
    
}


//MARK: - Dismiss keyboard when user tap outside UITextField

extension WeatherViewController {
    
    func dismissKey() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(WeatherViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        searchTextField.endEditing(true)
    }
}


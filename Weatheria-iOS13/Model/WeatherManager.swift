//
//  WeatherManager.swift
//  Weatheria-iOS13
//
//  Created by DDD on 05/05/20.
//  Copyright © 2020 Dandun Adi. All rights reserved.
//

import Foundation

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    let appId = "ad3c29f34a50ed3cc67d6149fbffd87d"
    let apiUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    
    func fetchURL(lat: Double, lon: Double) {
        let urlString = "\(apiUrl)&appid=\(appId)&lat=\(lat)&lon=\(lon)"
        getWeatherObject(from: urlString)
    }
    
    func fetchURL(by cityName: String) {
        let urlString = "\(apiUrl)&appid=\(appId)&q=\(cityName)"
        getWeatherObject(from: urlString)
    }
    
    func getWeatherObject(from urlString: String) {
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.delegate?.didError(error!)
                return
            }
            if let safeData = data {
                if let weatherModel = self.parseJSON(safeData) {
                    self.delegate?.didUpdateWeather(self, weatherModel: weatherModel)
                }
            }
        }
        task.resume()
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temperature = decodedData.main.temp
            let cityName = decodedData.name
            
            return WeatherModel(id: id, temperature: temperature, cityName: cityName)
            
        } catch  {
            print(error)
            return nil
        }
    }
    
}

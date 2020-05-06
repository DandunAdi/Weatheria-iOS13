//
//  WeatherModel.swift
//  Weatheria-iOS13
//
//  Created by DDD on 05/05/20.
//  Copyright © 2020 Dandun Adi. All rights reserved.
//

import Foundation

struct WeatherModel {
    let id: Int
    let temperature: Double
    let cityName: String
    let weatherDescription:String
    
    var temperatureString: String {
        String(format: "%.0f", temperature)
    }
    
    // return icon name based on weather id from API
    var weatherIconData: String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
}

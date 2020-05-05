//
//  WeatherData.swift
//  Weatheria-iOS13
//
//  Created by DDD on 05/05/20.
//  Copyright © 2020 Dandun Adi. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Weather: Codable {
    let id: Int
}

struct Main: Codable {
    let temp: Double
}

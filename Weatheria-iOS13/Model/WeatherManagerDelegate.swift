//
//  WeatherManagerDelegate.swift
//  Weatheria-iOS13
//
//  Created by DDD on 05/05/20.
//  Copyright © 2020 Dandun Adi. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weatherModel: WeatherModel)
    func didError(_ error: Error)
}

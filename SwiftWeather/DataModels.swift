//
//  DataModels.swift
//  SwiftWeather
//
//  Created by Joselyn on 7/21/23.
//

import Foundation

struct CurrentConditions: Decodable {
    let locationName : String
    /* let currentTemp : Float
    let feelsLike : Float
    let minTemp : Float
    let maxTemp : Float
    let humidity : Int
    let pressure : Int */
    
    enum CodingKeys: String, CodingKey {
        case locationName = "name"
    }
}

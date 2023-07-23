//
//  DataModels.swift
//  SwiftWeather
//
//  Created by Joselyn on 7/21/23.
//

import Foundation

/*
 This is the Data Model file, and is pretty similar to the treatment of the data model in Kotlin.
 
 Swift                          vs.                         Kotlin
 declared with 'struct'                                     declared with 'data class'
 'Decodable' interface allows data class                    Requires use of external library (Moshi) to interpret
    to be constructed from JSON                                 JSON data
 Use of 'enum Coding Keys' structure to help Swift          Moshi uses the @Json annotation to perform this function
    contruct the object from JSON
 
 Both require that the internal data object structure mirror the structure of the JSON object you are trying to encode
 */

struct CurrentConditions: Decodable {
    let currentWeatherList : Array<CurrentWeather>
    let locationName : String
    let weatherData : WeatherData
    
    enum CodingKeys: String, CodingKey {
        case locationName = "name"
        case currentWeatherList = "weather"
        case weatherData = "main"
    }
    
}

struct CurrentWeather: Decodable {
    let icon : String
    
    enum CodingKeys: String, CodingKey {
        case icon = "icon"
    }
}

struct WeatherData: Decodable {
    let currentTemp : Float
    let feelsLike : Float
    let minTemp : Float
    let maxTemp : Float
    let humidity : Int
    let pressure : Int
    
    enum CodingKeys: String, CodingKey {
        case currentTemp = "temp"
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case humidity = "humidity"
        case pressure = "pressure"
    }
}

struct MultiForecast: Decodable {
    let count : Int
    let forecastList : Array<DayForecast>
    
    enum CodingKeys: String, CodingKey {
        case count = "cnt"
        case forecastList = "list"
    }
}

struct DayForecast: Decodable {
    let date : Int64
    let sunrise : Int64
    let sunset : Int64
    let tempData : ForecastTemp
    let currentWeatherList : Array<CurrentWeather>
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case tempData = "temp"
        case currentWeatherList = "weather"
    }
    
}

struct ForecastTemp: Decodable {
    let day : Float
    let min : Float
    let max : Float
}

/*
{
    "coord": {
        "lon": -93.0107,
        "lat": 44.9414
    },
    "weather": [
        {
            "id":802,
            "main":"Clouds",
            "description":"scattered clouds",
            "icon":"03d"
        }
    ],
    "base":"stations",
    "main": {
        "temp":301.97,
        "feels_like":302.04,
        "temp_min":299.86,
        "temp_max":304.13,
        "pressure":1009,
        "humidity":45
    },
    "visibility":10000,
    "wind": {
        "speed":6.69,
        "deg":250,
        "gust":11.32
    },
    "clouds": {
        "all":40
    },
    "dt":1690057252,
    "sys": {
        "type":2,
        "id":2003983,
        "country":"US",
        "sunrise":1690022779,
        "sunset":1690077018
    },
    "timezone":-18000,
    "id":0,
    "name":"Saint Paul",
    "cod":200
 }
 */

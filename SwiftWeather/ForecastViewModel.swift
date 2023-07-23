//
//  ForecastViewModel.swift
//  SwiftWeather
//
//  Created by Joselyn on 7/23/23.
//

import Foundation
import UIKit

class ForeCastViewModel : ObservableObject {
    @Published var count = 0
    @Published var forecastList = [DayForecast]()
    
    init() {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast/daily?zip=55119,us&units=imperial&cnt=16&appid=2ba6a68c2752676b1f6a031bb637be59"
        let url = URL(string: urlString)
        let defaultSession = URLSession(configuration: .default)
        let dataTask = defaultSession.dataTask(with: url!) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if (error != nil) {
                print(error!)
                return
            }
            do {
                let json = try JSONDecoder().decode(MultiForecast.self, from: data!)
                self.count = json.count
                self.forecastList = json.forecastList
            } catch {
                print("Error converting JSON")
                return
            }
        }
        dataTask.resume()
    }
}

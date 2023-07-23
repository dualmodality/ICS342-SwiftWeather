//
//  CurrentConditionsViewModel.swift
//  SwiftWeather
//
//  Created by Joselyn on 7/21/23.
//

import Foundation
import UIKit

/*
 So, in line with Apple's general philosophy of trying to keep as much in-house and under their thumb as possible, Swift has
 internal libraries implemented to make REST calls and interpret JSON data, rather than relying on third-party libraries
 like Retrofit and Moshi. Since they're internal libraries, you don't have to declare their implementations in the build
 manager and mess around with dependency injection.
 
 To get the live data, the ViewModel has to be declared to conform to the ObervableObject interface. I think that the values that
 need to be checked live need to be annotated with @Published.
 
 */

class CurrentConditionsViewModel : ObservableObject {
    
    @Published var locationName = "Nowhere"
    @Published var currentTemp = 42
    @Published var feelsLike = 42
    @Published var minTemp = 0
    @Published var maxTemp = 999
    @Published var humidity = 100
    @Published var pressure = 1000
    
    init() {
        /* Here is where the API call is made. After I fully implement pushing data from the VM to the View, I'm going to go back
         and see if I can't refactor this into a separate file so that I can reuse the API call to implement the Forecast screen
         as well. I have the file ApiCaller, but right now it's not doing anything.*/
        let urlString =  "https://api.openweathermap.org/data/2.5/weather?zip=55119,us&units=imperial&appid=2ba6a68c2752676b1f6a031bb637be59"
        let url = URL(string: urlString)
        let defaultSession = URLSession(configuration: .default)
        let dataTask = defaultSession.dataTask(with: url!) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if (error != nil) {
                print(error!)
                self.locationName = "Error1"
                self.currentTemp = 0
                return
            }
            
            do {
                let json = try JSONDecoder().decode(CurrentConditions.self, from: data!)
                self.locationName = json.locationName
                self.currentTemp = Int(json.weatherData.currentTemp)
                self.feelsLike = Int(json.weatherData.feelsLike)
                self.minTemp = Int(json.weatherData.minTemp)
                self.maxTemp = Int(json.weatherData.maxTemp)
                self.humidity = json.weatherData.humidity
                self.pressure = json.weatherData.pressure
            } catch {
                print(error)
                self.locationName = "Error2"
                self.currentTemp = 999
                return
            }
        }
        dataTask.resume()
    }
}

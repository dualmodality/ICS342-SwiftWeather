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
    
    @Published var userZip : String? = "55119";
    @Published var currentConditions = CurrentConditions(currentWeatherList: [CurrentWeather(icon: "10d")], locationName: "No Data", weatherData: WeatherData(currentTemp: 0, feelsLike: 0, minTemp: 0, maxTemp: 0, humidity: 0, pressure: 0))
    @Published var userUnits = "imperial";
    @Published var currentConditionsIcon = UIImage(named: "CurrentConditionsIcons");
    private let apiService : APIService;
    @Published var showInvalidZipWarning : Bool = false;
    
    init() {
        self.apiService = APIService();
        Task {
            await getCurrentConditions();
        }
    }
    
    func getCurrentConditions() async {
        if validateZip() {
            do {
                currentConditions = await apiService.getCurrentConditions(zipCode: userZip!, units: userUnits) ?? CurrentConditions(currentWeatherList: [CurrentWeather(icon: "10d")], locationName: "No Data", weatherData: WeatherData(currentTemp: 0, feelsLike: 0, minTemp: 0, maxTemp: 0, humidity: 0, pressure: 0));
                if (currentConditions.locationName != "No Data") {
                    currentConditionsIcon = await apiService.getIcon(iconString: currentConditions.currentWeatherList.first!.icon)
                }
            }
        }
            
    }
        
    func validateZip() -> Bool {
        if ( (userZip == nil) || (userZip!.count != 5) || (!(userZip!.allSatisfy{ char in char.isNumber})) ) {
            showInvalidZipWarning = true;
            return false;
        } else {
            return true;
        }
    }
    
    
    /*
    
    @Published var locationName = "Nowhere"
    @Published var currentTemp = 42
    @Published var feelsLike = 42
    @Published var minTemp = 0
    @Published var maxTemp = 999
    @Published var humidity = 100
    @Published var pressure = 1000
    @Published var iconString : String?
    @Published var icon = UIImage(named: "CurrentConditionsIcons")
    
    init() {
        
        /* Here is where the API call is made. I couldn't quite figure out an easy way to pull this into an ApiCaller Object and then use that
         Object to make API calls. The problem is right now that I don't understand how to get the data collected by dataTask exposed outside
         of the dataTask object. I would need to dig a bit deeper into how the structure of the URLSession interface works to fully
         understand what it's doing and how I need to interact with it. Right now things are kind of kludgy by work, and I'm going to
         say I'm content with that for now. There almost certainly is a more elegant way to structure this than what I'm doing, though. */
        
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
                self.iconString = "https://openweathermap.org/img/wn/" + json.currentWeatherList.first!.icon + "@2x.png"
                if let data = try? Data(contentsOf: URL(string: self.iconString!)!) {
                    self.icon = UIImage(data: data)
                }
            } catch {
                print(error)
                self.locationName = "Error2"
                self.currentTemp = 999
                return
            }
        }
        dataTask.resume()
     
        
        
    }
    
     */
         
    
}

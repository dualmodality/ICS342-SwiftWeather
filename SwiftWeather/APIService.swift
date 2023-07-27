//
//  APIService.swift
//  SwiftWeather
//
//  Created by Joselyn on 7/27/23.
//

import Foundation
import UIKit

class APIService {
    
    private let session = URLSession(configuration: .default);
    private let baseUrl = "https://api.openweathermap.org/data/2.5/";
    private let appid = "2ba6a68c2752676b1f6a031bb637be59";
    private let iconHead = "https://openweathermap.org/img/wn/";
    private let iconTail = "@2x.png";
    
    func getCurrentConditions(zipCode : String = "55119", units : String = "imperial") async -> CurrentConditions? {
        
        let apiString = baseUrl + "weather?zip=" + zipCode + ",us&units=" + units + "&appid=" + appid;
        let url = URL(string: apiString)
        var current : CurrentConditions?
        do {
            current = try await JSONDecoder().decode(CurrentConditions.self, from: session.data(from: url!).0)
            return current;
        } catch {
            print("Bleh")
            return nil;
        }
        
    }
    
    func getIcon(iconString : String) async -> UIImage {
        var currentIcon : UIImage = UIImage(named: "CurrentConditionsIcons")!
        do {
            let iconUrlString = iconHead + iconString + iconTail
            let imageResponse = try await session.data(from: URL(string: iconUrlString)!);
            currentIcon = UIImage(data: imageResponse.0)!;
        } catch {
            currentIcon = UIImage(named: "CurrentConditionsIcons")!
            print("Error loading icon; default displayed");
            
        }
        return currentIcon;
    }
    
    func getForecast(zipCode : String = "55119", units : String = "imperial", count : Int = 16) async -> ForecastDump? {
        let apiString = baseUrl + "forecast/daily?zip=" + zipCode + "&units=" + units + "&cnt=" + String(count) + "&appid=" + appid;
        var forecastList : ForecastDump?
        do {
            let response = try await session.data(from: URL(string: apiString)!);
            forecastList = try JSONDecoder().decode(ForecastDump.self, from: response.0);
        } catch {
            print("Error loading API");
            forecastList = nil;
        }
        return forecastList;
    }
}
/*
 let dataTask = session.dataTask(with: url!) {
     (data: Data?, response: URLResponse?, error: Error?) in
     if (error != nil) {
         print(error!)
         if (currentVM.currentConditions == nil) {
             currentVM.loadState = false;
         }
         return;
     }
     do {
         currentVM.currentConditions = try JSONDecoder().decode(CurrentConditions.self, from: data!)
         currentVM.loadState = true;
     } catch {
         print(response ?? "Catch Block Default");
     }
 }
 dataTask.resume()
 */

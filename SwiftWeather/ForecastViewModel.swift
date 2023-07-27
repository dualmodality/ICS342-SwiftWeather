//
//  ForecastViewModel.swift
//  SwiftWeather
//
//  Created by Joselyn on 7/23/23.
//

import Foundation
import UIKit

class ForeCastViewModel : ObservableObject {
    @Published var count : Int = 16;
    @Published var userZip : String? = "55119";
    @Published var userUnits = "imperial";
    @Published var showInvalidZipWarning : Bool = false;
    @Published var MultiDay : [DayForecast] = []
    
    private let apiService : APIService;
    
    init() {
        self.apiService = APIService();
        Task {
            await getForecast();
        }
    }
    
    func getForecast() async {
        if (validateZip()) {
            MultiDay = []
            var forecastDump = await apiService.getForecast(zipCode: userZip!, units: userUnits, count: count)!;
            for day in forecastDump.dumpList {
                let iconString = day.currentWeatherList.first!.icon;
                let newDay = DayForecast(
                    icon: await apiService.getIcon(iconString: iconString),
                    date: day.date,
                    sunrise: day.sunrise,
                    sunset: day.sunset,
                    dayTemp: day.tempData.day,
                    minTemp: day.tempData.min,
                    maxTemp: day.tempData.max
                )
                MultiDay.append(newDay)
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
}

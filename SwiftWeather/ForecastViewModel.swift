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
    @Published var forecastList = MultiForecast(count: 0, forecastList: [])
    @Published var iconsArray : [UIImage] = []
    private let apiService : APIService;
    
    init() {
        self.apiService = APIService();
        Task {
            await getForecast();
        }
    }
    
    func getForecast() async {
        if (validateZip()) {
            self.forecastList = await apiService.getForecast(zipCode: userZip!, units: userUnits, count: count)!;
            for (index, day) in forecastList.forecastList.enumerated() {
                let iconString = day.currentWeatherList.first?.icon;
                self.iconsArray[index] = await apiService.getIcon(iconString: iconString!)
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

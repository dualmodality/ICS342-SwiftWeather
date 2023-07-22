//
//  CurrentConditionsViewModel.swift
//  SwiftWeather
//
//  Created by Joselyn on 7/21/23.
//

import Foundation

class CurrentConditionsViewModel {
    let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?zip=55119,us&units=imperial&appid=2ba6a68c2752676b1f6a031bb637be59")
    
    URLSession.shared.fetchData(for: url) {
        (result: Result<CurrentConditions, Error>) in
        switch result {
            case .success(let currentConditions):
            //Do I need to do something here?
            case .failure(let error):
            //I think I should do something here
        }
    }
}

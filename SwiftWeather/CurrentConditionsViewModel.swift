//
//  CurrentConditionsViewModel.swift
//  SwiftWeather
//
//  Created by Joselyn on 7/21/23.
//

import Foundation
import UIKit

class CurrentConditionsViewModel : ObservableObject {
    
    @Published var locationName : String
    
    init() {
        let urlString =  "https://api.openweathermap.org/data/2.5/weather?zip=55119,us&units=imperial&appid=2ba6a68c2752676b1f6a031bb637be59"
        let url = URL(string: urlString)
        let defaultSession = URLSession(configuration: .default)
        self.locationName = ""
        let dataTask = defaultSession.dataTask(with: url!) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if (error != nil) {
                print(error!)
                self.locationName = "Error1"
                return
            }
            
            do {
                let json = try JSONDecoder().decode(CurrentConditions.self, from: data!)
                print("in the do block")
                print(json.locationName)
                self.locationName = json.locationName
            } catch {
                print(error)
                self.locationName = "Error2"
                return
            }
        }
        dataTask.resume()
        print("Hello " + getLocationName())
    }
    
    func getLocationName() -> String {
        return self.locationName
    }
    
    /*URLSession.shared.fetchData(for: url) {
        (result: Result<CurrentConditions, Error>) in
        switch result {
            case .success(let currentConditions):
            //Do I need to do something here?
            case .failure(let error):
            //I think I should do something here
        }
    } */
}

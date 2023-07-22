//
//  ApiCaller.swift
//  SwiftWeather
//
//  Created by Joselyn on 7/21/23.
//

import Foundation

class ApiCaller {
    let session = URLSession.shared
    var dataTask: URLSessionDataTask?
    func getCurrentConditions() -> CurrentConditions {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?zip=55119,us&units=imperial&appid=2ba6a68c2752676b1f6a031bb637be59")
        dataTask?.cancel()
        dataTask = session.dataTask(with: url!)
        dataTask?.resume()
        
    }
}

/*extension URLSession {
    func fetchData<T: Decodable>(at url: URL, completion: @escaping((Result<T, Error>) -> Void)) {
        self.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let currentConditions = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(currentConditions))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }
} */

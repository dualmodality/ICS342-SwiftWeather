//
//  ApiCaller.swift
//  SwiftWeather
//
//  Created by Joselyn on 7/21/23.
//

import Foundation

extension URLSession {
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
}

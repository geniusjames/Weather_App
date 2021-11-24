//
//  URLSessionRequest.swift
//  WeatherApp
//
//  Created by Geniusjames on 21/11/2021.
//

import Foundation

extension URLSession{
    enum CustomError: Error{
        case invalidURL
        case invalidData
    }
    func request<T: Codable>(url: URL?,
                             expecting: T.Type,
                             completion: @escaping (Result<T, Error>) -> Void){
        
        guard let url = url else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        let task = self.dataTask(with: url){data, response, error in
            guard let data = data else {
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("HTTP response error")
                return
            }
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

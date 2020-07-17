//
//  NetworkCommunicator.swift
//  WeatherDemo
//
//  Created by Davi Chaves on 7/17/20.
//  Copyright © 2020 Davi Chaves. All rights reserved.
//

import Foundation
import SwiftyJSON

class NetworkCommunicator {
    
    static let shared = NetworkCommunicator()
    
    let apiKey = "0325cb9503ec0a31e4090bbbc9085fae"
    var lat = "60.99"
    var long = "30.0"
    let baseUrl = "https://api.openweathermap.org/data/2.5"
    
    let session = URLSession(configuration: .default)
    
    func buildURL() -> String {
        return baseUrl + "/weather?lat=" + lat + "&lon=" + long + "&units=imperial" + "&appid=" + apiKey
    }
    
    func setLatitude(_ latitude: Double) {
        lat = String(latitude)
    }
    
    func setLongitude(_ longitude: Double) {
        long = String(longitude)
    }
    
    func getWeather(onSuccess: @escaping (Dictionary<String, Any>?) -> Void, onError: @escaping (String) -> Void) {
        guard let url = URL(string: buildURL()) else {
            onError("Error building URL")
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let dictionary = self.parseDictionary(fromData: data)
                        onSuccess(dictionary)
                    } else {
                        onError("Response wasn't 200. It was: " + "\n\(response.statusCode)")
                    }
                } catch {
                    onError(error.localizedDescription)
                }
            }
            
        }
        task.resume()
    }
    
    func parseDictionary(fromData data: Data) -> Dictionary<String, Any>? {
        do {
            let json = try JSON(data: data)
            return json.dictionaryObject
        }
        catch {
            return nil
        }
    }
}

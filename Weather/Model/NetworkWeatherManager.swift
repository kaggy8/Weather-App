//
//  NetworkWeatherManager.swift
//  Weather
//
//  Created by Stanislav Demyanov on 01.06.2022.
//

import Foundation

struct NetworkWeatherManager {
    func fetchCurrentWeather(for city: String) {
        let urlString =
        "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(city)&days=5&aqi=no&alerts=no"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                let dataString = String(data: data, encoding: .utf8)
                print(dataString!)
            }
        }
        task.resume()
    }
}

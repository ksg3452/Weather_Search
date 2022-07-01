//
//  APIModel.swift
//  Weather_Search
//
//  Created by Sean Kim on 2022/06/27.
//

import Foundation

struct WeatherModel: Codable {
    let weather : [Weather]
    let temp: Temp
    let wind: Wind
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case weather
        case temp = "main"
        case wind
        case name
    }
    
}

struct Weather: Codable {
    let id: Int
    let main, description, icon : String
}

struct Temp: Codable {
    let temp,
        feelsLike,
        minTemp,
        maxTemp,
        pressure,
        humidity: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case pressure
        case humidity
    }
    
}

struct Wind: Codable {
    let speed, deg : Double
}

struct ErrorMessage: Codable{
    let message: String
}

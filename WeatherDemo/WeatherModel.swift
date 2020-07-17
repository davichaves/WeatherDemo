//
//  WeatherModel.swift
//  WeatherDemo
//
//  Created by Davi Chaves on 7/17/20.
//  Copyright © 2020 Davi Chaves. All rights reserved.
//

import Foundation

struct Result: Codable {
    let coord: Coord
    let weather: Weather
    let base: String
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: String
    let id: Int
    let name: String
    let cod: String
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let pressure: Int
    let humidity: Int
    let temp_max: Double
    let temp_min: Double
    let sea_level: Double
    let grnd_level: Double
}

struct Wind: Codable {
    let speed: Double
    let deg: Double
}

struct Clouds: Codable {
    let all: Int
}

struct Sys: Codable {
    let message: Double
    let country: String
    let sunrise: Int
    let sunset: Int
}

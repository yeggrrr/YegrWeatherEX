//
//  ThreeHoursWeatherData.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/12/24.
//

import Foundation

struct ThreeHoursFiveDaysWeatherData: Decodable {
    let list: [List]
    let city: City
    
    struct List: Decodable {
        let date: Int
        let main: Main
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let visibility: Int
        let dateText: String
        
        enum CodingKeys: String, CodingKey {
            case date = "dt"
            case main = "main"
            case weather = "weather"
            case clouds = "clouds"
            case wind = "wind"
            case visibility = "visibility"
            case dateText = "dt_txt"
        }
        
        struct Main: Decodable {
            let temp: Double
            let tempMin: Double
            let tempMax: Double
            
            enum CodingKeys: String, CodingKey {
                case temp = "temp"
                case tempMin = "temp_min"
                case tempMax = "temp_max"
            }
        }
        
        struct Weather: Decodable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }

        struct Clouds: Decodable {
            let all: Int
        }

        struct Wind: Decodable {
            let speed: Double
            let deg: Int
            let gust: Double
        }
    }
    
    struct City: Decodable {
        let id: Int
        let name: String
        let coord: Coord
        let country: String
        
        struct Coord: Decodable {
            let lat: Double
            let lon: Double
        }
    }
}




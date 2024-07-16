//
//  APIRequest.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/11/24.
//

import Foundation
import Alamofire

enum APIRequest {
    case current(id: Int)
    case threeHours(id: Int)
    
    var baseURL: String {
        return "https://api.openweathermap.org/data/2.5/"
    }
    
    var endpoint: String {
        switch self {
        case .current(_):
            return baseURL + "weather"
        case .threeHours(_):
            return baseURL + "forecast"
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .current(let id):
            return ["appid": APIKey.weatherKey, "id": "\(id)", "lang": "kr", "units": "metric"]
        case .threeHours(let id):
            return ["appid": APIKey.weatherKey, "id": "\(id)", "lang": "kr", "units": "metric"]
        }
    }
}

// enum AFAPIRequest {
//     case current(id: Int)
//     case threeHours(id: Int)
//     
//     var baseURL: String {
//         return "https://api.openweathermap.org/data/2.5/"
//     }
//     
//     var endpoint: URL {
//         switch self {
//         case .current(let id):
//             return URL(string: baseURL + "weather?id=\(id)")!
//         case .threeHours(let id):
//             return URL(string: baseURL + "forecast?id=\(id)")!
//         }
//     }
//     
//     var method: HTTPMethod {
//         return .get
//     }
//     
//     var parameter: Parameters {
//         return ["appid": APIKey.weatherKey, "lang": "kr", "units": "metric"]
//     }
// }

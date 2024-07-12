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
    case threeHours(lat: Double, lon: Double)
    
    var baseURL: String {
        return "https://api.openweathermap.org/data/2.5/"
    }
    
    var endpoint: URL {
        switch self {
        case .current(id: let id):
            return URL(string: baseURL + "weather?id=\(id)")!
        case .threeHours(lat: let lat, lon: let lon):
            return URL(string: baseURL + "forecast?lat=\(lat)&lon=\(lon)")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        return ["appid": APIKey.weatherKey, "lang": "kr", "units": "metric"]
    }
}

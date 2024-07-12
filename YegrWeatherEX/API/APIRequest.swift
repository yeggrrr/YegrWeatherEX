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
    
    var baseURL: String {
        return "https://api.openweathermap.org/data/2.5/"
    }
    
    // https://api.openweathermap.org/data/2.5/forecast?lat=37.654165&lon=127.049696&appid=9bb54d561628b0f2871ac02d0cf2f98b
    
    var endpoint: URL {
        switch self {
        case .current(id: let id):
            return URL(string: baseURL + "weather?id=\(id)")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        return ["appid": APIKey.weatherKey, "lang": "kr"]
    }
}

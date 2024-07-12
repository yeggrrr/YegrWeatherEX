//
//  APICall.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/11/24.
//

import Foundation
import Alamofire

class APICall {
    static let shared = APICall()
    
    private init() { }
    
    func callRequest(api: APIRequest, completion: @escaping (CurrentWeatherData) -> Void, errorHandler: @escaping (String) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameter).responseDecodable(of: CurrentWeatherData.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                errorHandler(error.localizedDescription)
                print(error)
            }
        }
    }
}

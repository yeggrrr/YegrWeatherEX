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
    
    // func callRequest<T:Decodable>(api: APIRequest, model: T.Type, completion: @escaping (T?) -> Void, errorHandler: @escaping (String) -> Void) {
    //     AF.request(api.endpoint, method: api.method, parameters: api.parameter).responseDecodable(of: T.self) { response in
    //         switch response.result {
    //         case .success(let value):
    //             completion(value)
    //         case .failure(let error):
    //             errorHandler(error.localizedDescription)
    //             print(error)
    //         }
    //     }
    // }
    
    func callRequest<T:Decodable>(api: APIRequest, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: api.endpoint) else { return }
        let queryItemArray = api.parameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        urlComponents.queryItems = queryItemArray
        
        guard let requestURL = urlComponents.url else { return }
    
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result.self))
                }
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
        .resume()
    }
}

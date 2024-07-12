//
//  MainViewModel.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/12/24.
//

import Foundation

class MainViewModel {
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    var outputWeatherData: Observable<CurrentWeatherData?> = Observable(nil)
    
    init() {
        transform()
    }
    
    func transform() {
        inputViewDidLoadTrigger.bind { _ in
            self.callRequest()
        }
    }
    
    func callRequest() {
        APICall.shared.callRequest(api: .current(id: 1835847), model: CurrentWeatherData.self) { weatherData in
            self.outputWeatherData.value = weatherData
        } errorHandler: { error in
            print(error)
        }
    }
}

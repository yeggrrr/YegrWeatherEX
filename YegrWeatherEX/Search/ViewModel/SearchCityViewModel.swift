//
//  SearchCityViewModel.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/14/24.
//

import Foundation

final class SearchCityViewModel {
    var inputSearchList: Observable<[City]> = Observable([])
    var outputSearhList: Observable<[City]> = Observable([])
    
    init() {
        print(">>> SearchCityViewModel init")
        
        inputSearchList.bind { [weak self] city in
            self?.outputSearhList.value = city
        }
    }
    
    deinit {
        print(">>> SearchCityViewModel deinit")
    }
}

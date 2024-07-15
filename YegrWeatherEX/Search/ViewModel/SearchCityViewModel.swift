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
        inputSearchList.bind { city in
            self.outputSearhList.value = city
        }
    }
}

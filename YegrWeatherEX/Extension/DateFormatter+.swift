//
//  DateFormatter+.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/12/24.
//

import Foundation

extension DateFormatter {    
    static let onlyDateFormatter: DateFormatter = {
        let dateFormat = DateFormatter()
        dateFormat.locale = Locale(identifier: "ko_KR")
        dateFormat.dateFormat = "yyyyMMdd"
        return dateFormat
    }()
    
    static let OnlyHourDateFormatter: DateFormatter = {
        let dateFormat = DateFormatter()
        dateFormat.locale = Locale(identifier: "ko_KR")
        dateFormat.dateFormat = "HH시"
        return dateFormat
    }()
}

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
    
    static let onlyHourDateFormatter: DateFormatter = {
        let dateFormat = DateFormatter()
        dateFormat.locale = Locale(identifier: "ko_KR")
        dateFormat.dateFormat = "HH시"
        return dateFormat
    }()
    
    static let stringToDateFormatter: DateFormatter = {
        let dateFormat = DateFormatter()
        dateFormat.locale = Locale(identifier: "ko_KR")
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormat.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return dateFormat
    }()
    
    static let dayOfTheWeekDateFormatter: DateFormatter = {
        let dateFormat = DateFormatter()
        dateFormat.locale = Locale(identifier: "ko_KR")
        dateFormat.dateFormat = "E"
        return dateFormat
    }()
    
    static func longToShortDate(dateString: String) -> String {
        guard let date = DateFormatter.stringToDateFormatter.date(from: dateString) else { return "-" }
        return DateFormatter.onlyDateFormatter.string(from: date)
    }
    
    static func longToOnlyHour(dateString: String) -> String {
        guard let date = DateFormatter.stringToDateFormatter.date(from: dateString) else { return "-" }
        return DateFormatter.onlyHourDateFormatter.string(from: date)
    }
    
    static func DateTodayOfWeek(dateString: String) -> String {
        guard let date = DateFormatter.stringToDateFormatter.date(from: dateString) else { return "-" }
        return DateFormatter.dayOfTheWeekDateFormatter.string(from: date)
    }
}

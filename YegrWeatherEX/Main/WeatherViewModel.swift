//
//  WeatherViewModel.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/12/24.
//

import Foundation

class WeatherViewModel {
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    var outputWeatherData: Observable<CurrentWeatherData?> = Observable(nil)
    var outputThreeDaysData: Observable<[ThreeHoursFiveDaysWeatherData.List]> = Observable([])
    var outputTotalWeatherData: Observable<[[ThreeHoursFiveDaysWeatherData.List]]> = Observable([[]])
    
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
        
        APICall.shared.callRequest(api: .threeHours(id: 1835847), model: ThreeHoursFiveDaysWeatherData.self) { data in
            guard let data = data else { return }
            let list = data.list
            self.outputThreeDaysData.value = list.filter {
                let targetDateText = DateFormatter.longToShortDate(dateString: $0.dateText)
                let maxDateText = self.getDateText(add: 2)
                return targetDateText <= maxDateText
            }
            let day = list.filter { DateFormatter.longToShortDate(dateString: $0.dateText ) == self.getDateText(add: 0) }
            let secondDay = list.filter { DateFormatter.longToShortDate(dateString: $0.dateText ) == self.getDateText(add: 1) }
            let thirdDay = list.filter { DateFormatter.longToShortDate(dateString: $0.dateText ) == self.getDateText(add: 2) }
            let forthDay = list.filter { DateFormatter.longToShortDate(dateString: $0.dateText ) == self.getDateText(add: 3) }
            let fifthDay = list.filter { DateFormatter.longToShortDate(dateString: $0.dateText ) == self.getDateText(add: 4) }
            
            self.outputTotalWeatherData.value = [day, secondDay, thirdDay, forthDay, fifthDay]
        } errorHandler: { error in
            print(error)
        }
    }
    
    func getDateText(add day: Int) -> String {
        let today = Date()
        let calendar = Calendar(identifier: .gregorian)
        let dateComponents = DateComponents(day: day)
        let targetDate = calendar.date(byAdding: dateComponents, to: today)
        
        guard let targetDate = targetDate else { return "-" }
        let dateText = DateFormatter.onlyDateFormatter.string(from: targetDate)
        return dateText
    }
}

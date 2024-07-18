//
//  WeatherViewModel.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/12/24.
//

import Foundation

final class WeatherViewModel {
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    var outputWeatherData: Observable<CurrentWeatherData?> = Observable(nil)
    var outputThreeDaysData: Observable<[ThreeHoursFiveDaysWeatherData.List]> = Observable([])
    var outputTotalWeatherData: Observable<[[ThreeHoursFiveDaysWeatherData.List]]> = Observable([[]])
    var outputWeatherMaxMinData: Observable<[(Double, Double)?]> = Observable([])
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bind { _ in
            if CityRepository.shared.fetch().isEmpty {
                self.callRequest(id: 1835847)
            } else {
                guard let city = CityRepository.shared.fetch().first else { return }
                self.callRequest(id: city.cityId)
            }
        }
    }
    
    func callRequest(id: Int) {
        APICall.shared.callRequest(api: .current(id: id), model: CurrentWeatherData.self) { [weak self] response in
            switch response {
            case .success(let weatherData):
                self?.outputWeatherData.value = weatherData
            case .failure(let failure):
                print(failure)
            }
        }
        
        APICall.shared.callRequest(api: .threeHours(id: id), model: ThreeHoursFiveDaysWeatherData.self) { [weak self] response in
            switch response {
            case .success(let data):
                let list = data.list
                self?.outputThreeDaysData.value = list.filter {
                    let targetDateText = DateFormatter.longToShortDate(dateString: $0.dateText)
                    if let maxDateText = self?.getDateText(add: 2) {
                        return targetDateText <= maxDateText
                    }
                    
                    return false
                }
                
                let firstDay = list.filter { DateFormatter.longToShortDate(dateString: $0.dateText ) == self?.getDateText(add: 0) }
                let secondDay = list.filter { DateFormatter.longToShortDate(dateString: $0.dateText ) == self?.getDateText(add: 1) }
                let thirdDay = list.filter { DateFormatter.longToShortDate(dateString: $0.dateText ) == self?.getDateText(add: 2) }
                let forthDay = list.filter { DateFormatter.longToShortDate(dateString: $0.dateText ) == self?.getDateText(add: 3) }
                let fifthDay = list.filter { DateFormatter.longToShortDate(dateString: $0.dateText ) == self?.getDateText(add: 4) }
                
                self?.outputTotalWeatherData.value = [firstDay, secondDay, thirdDay, forthDay, fifthDay]
                
                let firstTemps = self?.getMaxMin(day: firstDay)
                let secondTemps = self?.getMaxMin(day: secondDay)
                let thirdTemps = self?.getMaxMin(day: thirdDay)
                let forthTemps = self?.getMaxMin(day: forthDay)
                let fifthTemps = self?.getMaxMin(day: fifthDay)
                
                self?.outputWeatherMaxMinData.value = [firstTemps, secondTemps, thirdTemps, forthTemps, fifthTemps]
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func getDateText(add day: Int) -> String {
        let today = Date()
        let calendar = Calendar(identifier: .gregorian)
        let dateComponents = DateComponents(day: day)
        let targetDate = calendar.date(byAdding: dateComponents, to: today)
        
        guard let targetDate = targetDate else { return "-" }
        let dateText = DateFormatter.onlyDateFormatter.string(from: targetDate)
        return dateText
    }
    
    func getMaxMin(day: [ThreeHoursFiveDaysWeatherData.List]) -> (Double, Double)? {
        guard !day.isEmpty else { return nil }
        let tempMaxList = day.map{ $0.main.tempMax }
        let tempMinList = day.map{ $0.main.tempMin }
        
        if let tempMax = tempMaxList.max(), let tempMin = tempMinList.min() {
            return (tempMax, tempMin)
        }
        
        return nil
    }
}

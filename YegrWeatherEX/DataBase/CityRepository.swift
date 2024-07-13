//
//  CityRepository.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/14/24.
//


import RealmSwift

class CityRepository {
    static let shared = CityRepository()
    
    private let realm = try! Realm()
    
    func findFilePath() {
        print(realm.configuration.fileURL ?? "-")
    }
    
    func fetch() -> [CityRealmModel] {
        return Array(realm.objects(CityRealmModel.self))
    }
    
    func add(item: CityRealmModel) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error, "Add Failed")
        }
    }
    
    func update(item: City) {
        do {
            let objects = realm.objects(CityRealmModel.self)
            guard let savedCity = objects.first else { return }
            try realm.write {
                let newCity = savedCity
                newCity.cityId = item.id
                newCity.name = item.name
                newCity.state = item.state
                newCity.country = item.country
                newCity.coordLon = item.coord.lon
                newCity.coordLat = item.coord.lat
                realm.add(newCity, update: .modified)
            }
        } catch {
            print(error, "Update Failed")
        }
    }
    
    func delete(item: CityRealmModel) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error, "Delete Failed")
        }
    }
}


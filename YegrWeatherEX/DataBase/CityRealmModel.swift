//
//  CityRealmModel.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/14/24.
//

import Foundation
import RealmSwift

class CityRealmModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var cityId: Int
    @Persisted var name: String
    @Persisted var state: String
    @Persisted var country: String
    @Persisted var coordLon: Double
    @Persisted var coordLat: Double

    convenience init(cityId: Int, name: String, state: String, country: String, coordLon: Double, coordLat: Double) {
        self.init()
        self.cityId = cityId
        self.name = name
        self.state = state
        self.country = country
        self.coordLon = coordLon
        self.coordLat = coordLat
    }
}

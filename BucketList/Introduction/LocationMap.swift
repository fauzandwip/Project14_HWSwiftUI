//
//  LocationMap.swift
//  BucketList
//
//  Created by Fauzan Dwi Prasetyo on 12/07/23.
//

import MapKit
import Foundation

struct LocationMap: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = LocationMap(id: UUID(), name: "Buckingham Palace", description: "Where Queen Elizabeth lives with her dorgis.", latitude: 51.501, longitude: -0.141)

    static func ==(lhs: LocationMap, rhs: LocationMap) -> Bool {
        lhs.id == rhs.id
    }
}

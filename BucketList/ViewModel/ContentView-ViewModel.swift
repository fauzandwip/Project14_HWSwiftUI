//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Fauzan Dwi Prasetyo on 13/07/23.
//

import MapKit
import SwiftUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                let decoded = try JSONDecoder().decode([Location].self, from: data)
                locations = decoded
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let encoded = try JSONEncoder().encode(locations)
                try encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                fatalError("Unable to save data.")
            }
        }
        
        func addLocation() {
            let location = Location(id: UUID(), name: "New Location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(location)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
    }
}

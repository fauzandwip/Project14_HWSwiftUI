//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Fauzan Dwi Prasetyo on 13/07/23.
//

import SwiftUI

// Challenge 3
extension EditView {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    class EditViewModel: ObservableObject {
        var location: Location
        
        @Published var name: String
        @Published var description: String
        
        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()
        
        init(location: Location) {
            self.location = location
            
            _name = Published(initialValue: location.name)
            _description = Published(initialValue: location.description)
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else {
                fatalError("Bad URL: \(urlString)")
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodedData = try JSONDecoder().decode(Result.self, from: data)
                
                Task { @MainActor in
                    // success – convert the array values to our pages array
                    pages = decodedData.query.pages.values.sorted()
                    loadingState = LoadingState.loaded
                }
            } catch {
                Task { @MainActor in
                    loadingState = LoadingState.failed
                }
            }
        }
    }
}

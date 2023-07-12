//
//  EditView.swift
//  BucketList
//
//  Created by Fauzan Dwi Prasetyo on 12/07/23.
//

import SwiftUI

struct EditView: View {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @Environment(\.dismiss) var dismiss
    var location: Location
    var onSave: (Location) -> Void
    
    @State private var name: String
    @State private var description: String
    
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("name", text: $name)
                    TextField("description", text: $description)
                }
                
                Section("Nearby...") {
                    switch loadingState {
                    case .loading:
                        ProgressView()
                    case .loaded:
                        ForEach(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place Details")
            .toolbar {
                Button("Save") {
                    var location = self.location
                    location.id = UUID()
                    location.name = name
                    location.description = description
                    
                    onSave(location)
                    dismiss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void ) {
        self.location = location
        self.onSave = onSave
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string: urlString) else {
            fatalError("Bad URL: \(urlString)")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(Result.self, from: data)
            
            // success – convert the array values to our pages array
            pages = decodedData.query.pages.values.sorted()
            loadingState = LoadingState.loaded
        } catch {
            loadingState = LoadingState.failed
            fatalError("Error: \(error.localizedDescription)")
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { _ in }
    }
}

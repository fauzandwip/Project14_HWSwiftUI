//
//  EditView.swift
//  BucketList
//
//  Created by Fauzan Dwi Prasetyo on 12/07/23.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    
    @EnvironmentObject var vm: EditViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("name", text: $vm.name)
                    TextField("description", text: $vm.description)
                }
                
                Section("Nearby...") {
                    switch vm.loadingState {
                    case .loading:
                        ProgressView()
                    case .loaded:
                        ForEach(vm.pages, id: \.pageid) { page in
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
                    var newLocation = vm.location
                    newLocation.id = UUID()
                    newLocation.name = vm.name
                    newLocation.description = vm.description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await vm.fetchNearbyPlaces()
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView() { _ in }
            .environmentObject(EditView.EditViewModel(location: Location.example))
    }
}

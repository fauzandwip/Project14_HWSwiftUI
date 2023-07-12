//
//  EditView.swift
//  BucketList
//
//  Created by Fauzan Dwi Prasetyo on 12/07/23.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var location: Location
    var onSave: (Location) -> Void
    
    @State private var name: String
    @State private var description: String
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("name", text: $name)
                    TextField("description", text: $description)
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
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void ) {
        self.location = location
        self.onSave = onSave
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { _ in }
    }
}

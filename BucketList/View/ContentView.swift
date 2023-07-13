//
//  ContentView.swift
//  BucketList
//
//  Created by Fauzan Dwi Prasetyo on 11/07/23.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isUnlocked {
                    ZStack {
                        Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                            MapAnnotation(coordinate: location.coordinate) {
                                VStack {
                                    Image(systemName: "star.circle")
                                        .resizable()
                                        .foregroundColor(.red)
                                        .frame(width: 44, height: 44)
                                        .background(.white)
                                        .clipShape(Circle())
                                    
                                    Text(location.name)
                                        .fixedSize()
                                }
                                .onTapGesture {
                                    viewModel.selectedPlace = location
                                }
                            }
                        }
                        .ignoresSafeArea()
                        
                        Circle()
                            .fill(.blue)
                            .opacity(0.3)
                            .frame(width: 32, height: 32)
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button {
                                    viewModel.addLocation()
                                } label: {
                                    Image(systemName: "plus")
                                    // challenge 1
                                    // label area will tapped
                                        .padding()
                                        .background(.black.opacity(0.75))
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .clipShape(Circle())
                                        .padding(.trailing)
                                }
                            }
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView() { newLocation in
                            viewModel.update(location: newLocation)
                        }
                        .environmentObject(EditView.EditViewModel(location: place))
                    }
                } else {
                    Button("Unlock Places") {
                        viewModel.authenticate()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
                    .clipShape(Capsule())
                }
            }
            // challenge 2
            .alert(isPresented: $viewModel.showingAuthenticationAlert) {
                Alert(title: Text("Authenticatin Error"), message: Text(viewModel.authenticationError), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

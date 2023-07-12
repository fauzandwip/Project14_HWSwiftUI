//
//  MapView.swift
//  BucketList
//
//  Created by Fauzan Dwi Prasetyo on 12/07/23.
//

import MapKit
import SwiftUI

struct MapView: View {
    @State var locations = [LocationMap]()
    @State private var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    @State private var selectedPlace: LocationMap?
    
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
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
                            selectedPlace = location
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
                            let location = LocationMap(id: UUID(), name: "New Location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
                            
                            locations.append(location)
                        } label: {
                            Image(systemName: "plus")
                        }
                        .padding()
                        .background(.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                    }
                }
            }
            .sheet(item: $selectedPlace) { place in
                EditView(location: place) { newLocation in
                    if let index = locations.firstIndex(of: place) {
                        locations[index] = newLocation
                    }
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(locations: [LocationMap.example])
    }
}

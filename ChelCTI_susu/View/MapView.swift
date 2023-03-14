//
//  MapView.swift
//  ChelCTI_susu
//
//  Created by Артем Васин on 16.07.2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var appState: AppState
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 54.42239539926753, longitude: 61.1865846), latitudinalMeters: 500000, longitudinalMeters: 500000)
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: Place.places) { place in
            //            MapMarker(coordinate: place.coordinate)
            MapAnnotation(coordinate: place.coordinate) {
                PlaceAnnotationView(title: place.name)
                    .onTapGesture {
                        appState.path.append(.address(place))
                    }
            }
        }
        .navigationTitle("Карта подразделений")
        .ignoresSafeArea()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PlaceAnnotationView: View {
    let title: String
    
    var body: some View {
        VStack(spacing: 0) {
            //            Text(title)
            //                .font(.callout)
//                .padding(5)
//                .background(Color(.white))
//                .cornerRadius(10)
            
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(.red)
            
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(.red)
                .offset(y: -5)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(AppState())
    }
}

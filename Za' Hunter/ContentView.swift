//
//  ContentView.swift
//  Za' Hunter
//
//  Created by Aneesh Pushparaj on 7/30/21.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var places = [Place]()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 42.0558, longitude: -87.6743), // Northwestern Campus Coordinates
        span: MKCoordinateSpan(
            latitudeDelta: 0.05,
            longitudeDelta: 0.05)
    )
    @StateObject var locationManager = LocationManager() // Locates to the Swift File(Location Manager)
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    var body: some View {
        Map(coordinateRegion: $region, // Sets up a map with the required variables and declarations active
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode,
            annotationItems: places) {place in
            MapAnnotation(coordinate: place.annotation.coordinate) {
                Marker(mapItem: place.mapItem) // Markes the map with a marker of "Pizza"
            }
        }
        .onAppear(perform: {
            performSearch(item: "Pizza")
        })
    }
    
    func performSearch(item: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = item
        searchRequest.region = region
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            if let response = response {
                for mapItem in response.mapItems {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = mapItem.placemark.coordinate
                    annotation.title = mapItem.name
                    places.append(Place(annotation: annotation, mapItem: mapItem))
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Place: Identifiable {
    let id = UUID()
    let annotation: MKPointAnnotation // Sets up dictionarys for where pizza locations are
    let mapItem: MKMapItem
}

struct Marker:View { // A view for the marker of where pizza locations are
    var mapItem: MKMapItem
    var body: some View {
        if let url = mapItem.url { // URL for the pizza locations
            Link(destination: url, label: {
                Image("Pizza") // Grabs image from Assets and displays as the marker
            })
        }
    }
}

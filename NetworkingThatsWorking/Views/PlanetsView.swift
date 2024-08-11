//
//  ContentView.swift
//  NetworkingThatsWorking
//
//  Created by Roman on 2024-08-10.
//

import SwiftUI

struct ContentView: View {
    
    @State private var planets: [Planet] = []
    private let planetsFetchingService = PlanetsFetchingService()
    
    var body: some View {
        NavigationStack {
            Group {
                if planets.isEmpty {
                    Text("No planets to display")
                        .task {
                            do {
                                planets = try await planetsFetchingService.fetchPlanets()
                            } catch {
                                print(">>>Failed to fetch planets with error: ", error)
                            }
                        }
                } else {
                    List {
                        ForEach(Array(planets.enumerated()), id: \.offset) { index, planet in
                            NavigationLink {
                                PlanetDetailView(planetIndex: index + 1)
                            } label: {
                                Text(planet.name)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Planets")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ContentView()
}

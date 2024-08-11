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
            if planets.isEmpty {
                ProgressView()
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
                            PlanetDetailView(planet: planet, planetIndex: index + 1)
                        } label: {
                            Text(planet.name)
                        }
                    }
                }
                .navigationTitle("Planets")
            }
        }
    }
}

#Preview {
    ContentView()
}

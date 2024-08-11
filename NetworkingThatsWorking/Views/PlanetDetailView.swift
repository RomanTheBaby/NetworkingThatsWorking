//
//  PlanetDetailView.swift
//  NetworkingThatsWorking
//
//  Created by Roman on 2024-08-10.
//

import SwiftUI

struct PlanetDetailView: View {
    @State private var planet: Planet?
    var planetIndex: Int
    private let planetsFetchingService = PlanetsFetchingService()
    
    var body: some View {
        if let planet {
            PlanetView(planet: planet)
        } else {
            ProgressView()
                .task {
                    do {
                        self.planet = try await self.planetsFetchingService.fetchPlanet(at: planetIndex)
                    } catch {
                        print("Failed to fetch planet with error: ", error)
                    }
                }
        }
    }
}

private struct PlanetView: View {
    var planet: Planet
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Population")
                    .fontWeight(.medium)
                Spacer()
                Text(planet.population)
            }
            
            Divider()
            
            HStack {
                Text("Climate")
                    .fontWeight(.medium)
                Spacer()
                Text(planet.climate)
            }
            
            Divider()
            
            HStack {
                Text("Terrain")
                    .fontWeight(.medium)
                Spacer()
                Text(planet.terrain)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(planet.name)
    }
}

//#Preview {
//    NavigationStack {
//        PlanetDetailView(
//            planet: Planet(
//                name: "Test Planet",
//                population: "123,456",
//                climate: "weird",
//                terrain: "desert"
//            ),
//            planetIndex: 2
//        )
//    }
//}

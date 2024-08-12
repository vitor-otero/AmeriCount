//
//  StatePopulationView.swift
//  AmeriCount
//
//  Created by Vitor Otero on 09/08/2024.
//

import SwiftUI
import api

struct StatePopulationView: View {
    @StateObject var stateViewModel = StatePopulationVM()
    @State private var isError: Bool = false
    @State private var errorMessage: String = ""
    @State private var searchText: String = ""

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20) {
                    // State Population Data
                    Section(header: Text("State Population")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                        .padding(.top, 10)) {
                        if stateViewModel.statePopulationData.isEmpty {
                            Text("No state population data available.")
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            SearchBar(text: $searchText)
                            NavigationView {
                                ScrollView {
                                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                                        ForEach(filteredStatePopulationData, id: \.idState) { entry in
                                            NavigationLink(destination: StateDetailView(state: entry)) {
                                                Text(entry.state ?? "")
                                                    .font(.headline)
                                                    .foregroundColor(.primary)
                                                    .frame(width: 100, height: 80) // Set fixed size for the button
                                                    .background(Color(.gray).opacity(0.2))
                                                    .cornerRadius(12)
                                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                            }
                                        }.foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
                .alert("Error", isPresented: $isError) {
                    Button("Ok") { }
                } message: {
                    Text(errorMessage)
                }
                .task {
                    await stateViewModel.fetchStatePopulation()
                }
            }
        }
    }

    var filteredStatePopulationData: [StatePopulationDto] {
        if searchText.isEmpty {
            return stateViewModel.statePopulationData
        } else {
            return stateViewModel.statePopulationData.filter { entry in
                entry.state?.localizedCaseInsensitiveContains(searchText) ?? false
            }
        }
    }
}

struct StatePopulationView_Previews: PreviewProvider {
    static var previews: some View {
        StatePopulationView()
    }
}


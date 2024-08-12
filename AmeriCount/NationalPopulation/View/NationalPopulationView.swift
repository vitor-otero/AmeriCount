//
//  NationalPopulationView.swift
//  AmeriCount
//
//  Created by Vitor Otero on 09/08/2024.
//

import SwiftUI
import api

struct NationalPopulationView: View {
    @StateObject var nationalViewModel = NationalPopulationVM()
    @State private var isError: Bool = false
    @State private var errorMessage: String = ""
    @State private var showDetails: [Int: Bool] = [:] // Track the visibility state for each year

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20) {
                    // National Population Data
                    Section(header: Text("National Population")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding(.bottom, 10)) {
                        if nationalViewModel.nationPopulationData.isEmpty {
                            Text("No national population data available.")
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            let sortedData = nationalViewModel.nationPopulationData.sorted { $0.year ?? "" < $1.year ?? "" }
                            
                            ForEach(Array(sortedData.enumerated()), id: \.offset) { index, entry in
                                let previousEntry = index > 0 ? sortedData[index - 1] : nil
                                let populationChange = (entry.population ?? 0) - (previousEntry?.population ?? 0)
                                let year = entry.year ?? ""
                                let showDetail = showDetails[index] ?? false
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Year: \(year)")
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        
                                        if index > 0 {
                                            if populationChange > 0 {
                                                Image(systemName: "arrowtriangle.up.fill")
                                                    .foregroundColor(.green)
                                            } else if populationChange < 0 {
                                                Image(systemName: "arrowtriangle.down.fill")
                                                    .foregroundColor(.red)
                                            }
                                            Text("(\(populationChange))")
                                                .font(.subheadline)
                                                .foregroundColor(populationChange > 0 ? .green : .red)
                                        }
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            showDetails[index] = !(showDetails[index] ?? false)
                                        }) {
                                            Image(systemName: showDetail ? "chevron.up" : "chevron.down")
                                                .foregroundColor(.black)
                                        }
                                    }
                                    
                                    if showDetail {
                                        Text("Population: \(entry.population ?? 0)")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding()
                                .background(Color(.systemBackground).opacity(0.8))
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
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
                    await fetchAllData()
                }
            }
        }
    }

    func fetchAllData() async {
        do {
            try await nationalViewModel.fetchNationPopulation()
        } catch {
            if let error = error as? NetworkError {
                errorMessage = error.localizedDescription
                isError = true
            }
        }
    }
}

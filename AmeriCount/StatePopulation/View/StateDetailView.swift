//
//  StateDetailView.swift
//  AmeriCount
//
//  Created by Vitor Otero on 12/08/2024.
//

import SwiftUI
import api

struct StateDetailView: View {
    var state: StatePopulationDto

    var body: some View {
     
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Details for \(state.state ?? "")")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack {
                        Text("Population:")
                            .fontWeight(.semibold)
                        Text("\(String(state.population ?? 0).replacingOccurrences(of: " ", with: ""))")
                    }
                    
                    HStack {
                        Text("State Code:")
                            .fontWeight(.semibold)
                        Text("\(state.slugState ?? "")")
                    }
                    
                    HStack {
                        Text("Year:")
                            .fontWeight(.semibold)
                        Text("\(String(state.idYear ?? 0).replacingOccurrences(of: " ", with: ""))")
                    }
                }
                .padding(.all, 10)
                
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }

}

//
//  MainView.swift
//  AmeriCount
//
//  Created by Vitor Otero on 09/08/2024.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            NationalPopulationView()
                .tabItem {
                    Label("National", systemImage: "globe")
                }
                .tag(0)

            StatePopulationView()
                .tabItem {
                    Label("State", systemImage: "map")
                }
                .tag(1)
        }
    }
}

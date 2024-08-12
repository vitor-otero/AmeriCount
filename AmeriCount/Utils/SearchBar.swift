//
//  SearchBar.swift
//  AmeriCount
//
//  Created by Vitor Otero on 12/08/2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .overlay(
                    HStack {
                        Spacer()
                        if !text.isEmpty {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(Color(.systemGray3))
                                    .padding(.trailing, 18)
                            }
                        }
                    }
                )
        }
        .padding(.top, 10)
    }
}

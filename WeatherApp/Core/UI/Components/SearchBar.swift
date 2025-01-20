//
//  SearchBar.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 20/01/25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let isLoading: Bool
    let placeholder: String

    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .foregroundStyle(.darkGray)
                .textFieldStyle(PlainTextFieldStyle())
                .customFont(.regular, size: Constants.fontSize)
                .padding(.leading, Constants.leadingInputPadding)
                .padding(.vertical, Constants.verticalInputPadding)
                .disabled(isLoading)

            if showClearButton {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: Constants.clearButtonImage)
                        .foregroundColor(.gray)
                }
                .padding(.trailing, Constants.trailingRightComponent)
            } else if isLoading {
                ProgressView()
                    .padding(.trailing, Constants.trailingRightComponent)
            } else {
                Image(.search)
                    .padding(.trailing, Constants.trailingRightComponent)
            }
        }
        .background(.whiteSmoke)
        .cornerRadius(Constants.cornerRadius)
    }
    
    private var showClearButton: Bool {
        !text.isEmpty && !isLoading
    }
    
    // MARK: - Constants
    private enum Constants {
        static let verticalInputPadding: CGFloat = 12
        static let leadingInputPadding: CGFloat = 20
        static let fontSize: CGFloat = 15
        static let trailingRightComponent: CGFloat = 20
        static let cornerRadius: CGFloat = 15
        static let clearButtonImage = "xmark.circle.fill"
    }
}

#Preview {
    SearchBar(
        text: .constant("text"),
        isLoading: false,
        placeholder: "Search Location"
    )
}

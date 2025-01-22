//
//  SearchBar.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 20/01/25.
//

import SwiftUI

struct SearchBar: View {
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        HStack {
            TextField(viewModel.placeholder, text: $viewModel.text)
                .foregroundStyle(.darkGray)
                .textFieldStyle(PlainTextFieldStyle())
                .customFont(.regular, size: Constants.fontSize)
                .padding(.leading, Constants.leadingInputPadding)
                .padding(.vertical, Constants.verticalInputPadding)
                .disabled(viewModel.disableSearch)

            if viewModel.showClearButton {
                Button(action: {
                    viewModel.text = ""
                }) {
                    Image(systemName: Constants.clearButtonImage)
                        .foregroundColor(.gray)
                }
                .padding(.trailing, Constants.trailingRightComponent)
            } else if viewModel.isLoading {
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
        viewModel: .init(
            text: "",
            isLoading: false,
            placeholder: "Search Location"
        )
    )
}

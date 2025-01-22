//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 21/01/25.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    enum ViewState {
        case waitingForInteraction
        case readyToSearch
        case searching
    }
    
    @Published
    var text: String = ""
    @Published
    private(set) var viewState: ViewState
    
    private var subscriptions = Set<AnyCancellable>()
    var searchCompletion: AsyncQueryClousure?
    let placeholder: String

    var allowClearText: Bool {
        !text.isEmpty
    }
    
    var disableSearch: Bool {
        viewState == .searching
    }

    init(
        text: String,
        isLoading: Bool,
        placeholder: String,
        searchCompletion: AsyncQueryClousure? = nil
    ) {
        self.text = text
        self.viewState = .waitingForInteraction
        self.placeholder = placeholder
        self.searchCompletion = searchCompletion
    }
    
    func viewDidLoad() async {
        $text
            .dropFirst()
            .removeDuplicates()
            .handleEvents(receiveOutput: { [weak self] value in
                self?.prepareToSearch(with: value)
            })
            .debounce(for: .seconds(3), scheduler: DispatchQueue.global())
            .sink { [weak self] text in
                self?.onSearchData(with: text)
        }
        .store(in: &subscriptions)
    }
    
    private func onSearchData(with cityName: String) {
        Task {
            guard !cityName.isEmpty else {
                await setState(.waitingForInteraction)
                return
            }
            await setState(.searching)
            await searchCompletion?(cityName)
            await setState(.waitingForInteraction)
        }
    }
    
    private func prepareToSearch(with text: String) {
        Task {
            await setState(text.isEmpty ? .waitingForInteraction : .readyToSearch)
        }
    }
    
    private func setState(_ newState: ViewState) async {
        await MainActor.run {
            viewState = newState
        }
    }
}

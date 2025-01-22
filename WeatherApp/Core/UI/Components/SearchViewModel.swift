//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 21/01/25.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published
    var text: String = ""
    @Published
    private(set) var isLoading: Bool = false
    @Published
    private(set) var disableSearch: Bool = false
    
    private var subscriptions = Set<AnyCancellable>()
    var searchCompletion: AsyncQueryClousure?
    let placeholder: String

    var showClearButton: Bool {
        !text.isEmpty && !isLoading && !disableSearch
    }

    init(
        text: String,
        isLoading: Bool,
        placeholder: String,
        searchCompletion: AsyncQueryClousure? = nil
    ) {
        self.text = text
        self.isLoading = isLoading
        self.placeholder = placeholder
        self.searchCompletion = searchCompletion
    }
    
    func viewDidLoad() async {
        $text
            .dropFirst()
            .removeDuplicates()
            .handleEvents(receiveOutput: {  value in
                Task { [weak self] in
                    await self?.showSearchAnimation(!value.isEmpty)
                }
            })
            .debounce(for: .seconds(3), scheduler: DispatchQueue.global())
            .sink { [weak self] text in
                self?.onSearchData(with: text)
        }
        .store(in: &subscriptions)
    }
    
    private func onSearchData(with cityName: String) {
        Task {
            await showSearchAnimation(!cityName.isEmpty)
            guard !cityName.isEmpty else { return }
            await enableSearch(false)
            await searchCompletion?(cityName)
            await showSearchAnimation(false)
            await enableSearch(true)
        }
    }
    
    private func showSearchAnimation(_ show: Bool) async {
        await MainActor.run {
            isLoading = show
        }
    }
    
    private func enableSearch(_ enabled: Bool) async {
        await MainActor.run {
            disableSearch = !enabled
        }
    }
}

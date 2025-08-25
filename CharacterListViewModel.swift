//
//  CharacterListViewModel.swift
//  RickDex
//
//  Created by Paloma Belenguer on 25/8/25.
//

import Foundation

@MainActor
final class CharacterListViewModel: ObservableObject {
    enum State: Equatable {
        case idle
        case loading
        case loaded
        case failed(APIError)
    }

    @Published private(set) var state: State = .idle
    @Published private(set) var characters: [Character] = []
    @Published private(set) var currentPage: Int = 1
    @Published private(set) var hasMore: Bool = true

    private let service: CharactersServicing

    // CLEAN: Inyección para testear fácilmente
    init(service: CharactersServicing = RickAndMortyAPI()) {
        self.service = service
    }

    func load() async {
        guard state != .loading, hasMore else { return }
        state = characters.isEmpty ? .loading : .loaded // mantiene lista al paginar
        do {
            let response = try await service.fetchCharacters(page: currentPage)
            characters += response.results
            currentPage += 1
            hasMore = (response.info.next != nil)
            state = .loaded
        } catch let apiError as APIError {
            state = .failed(apiError)
        } catch let urlError as URLError {
            state = .failed(.transport(urlError))
        } catch {
            state = .failed(.unknown)
        }
    }

    func retry() async {
        if case .failed = state { state = .idle }
        await load()
    }
}


//
//  CharactersViewModel.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 6/1/25.
//

import SwiftUI

final class CharactersViewModel: CharactersViewModelProtocol {
    // MARK: Published properties
    @Published var state: CharactersViewStates = .loading

    // MARK: Private properties
    private let service: CharactersServiceProtocol
    private var currentPage: Int = 1
    private var listOfFetchedCharacters: [CharacterModel] = []
    private var lastCharacterId: Int?
    private var isLoadingCharacters = false
    private var hasMorePages = true

    // MARK: Initialization
    init(service: CharactersServiceProtocol){
        self.service = service
        fetchCharacters()
    }

    // MARK: Methods
    func fetchCharacters() {
        guard !isLoadingCharacters, hasMorePages else { return }
        isLoadingCharacters = true

        Task {
            do {
                let listOfCharacters = try await service.getAllCharacters(
                    page: currentPage
                )
                let charactersToAppend: [CharacterModel] = listOfCharacters.results
                listOfFetchedCharacters.append(contentsOf: charactersToAppend)

                lastCharacterId = listOfCharacters.results.last?.id
                hasMorePages = listOfCharacters.info.next != nil

                if let lastId = listOfCharacters.results.last?.id {
                    lastCharacterId = lastId
                    await MainActor.run {
                        state = .loaded(
                            listOfCharacters: listOfFetchedCharacters,
                            lastChracterId: lastId
                        )
                    }
                    isLoadingCharacters = false
                } else {
                    await MainActor.run {
                        state = .loaded(
                            listOfCharacters: [],
                            lastChracterId: 0
                        )
                    }
                }
            } catch let error as RMNetworkError {
                state = .error(error: error)
                isLoadingCharacters = false
            }
        }
    }

    func loadMoreCharacters() {
        guard !isLoadingCharacters else { return }
        currentPage+=1
        fetchCharacters()
    }
}

// MARK: Testhooks
#if DEBUG

extension CharactersViewModel {
    var testHooks: TestHooks {
        return TestHooks(target: self)
    }

    struct TestHooks {
        private let target: CharactersViewModel

        fileprivate init(target: CharactersViewModel) {
            self.target = target
        }

        var service: CharactersServiceProtocol {
            return target.service
        }
    }
}

#endif

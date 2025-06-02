//
//  CharacterCoordinator.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 6/1/25.
//

import SwiftUI

final class CharactersCoordinator: RMCoordinator {

    // MARK: Private properties
    private let baseURL: String
    private var viewModel: CharactersViewModel?

    // MARK: Initialization
    init(baseURL: String) {
        self.baseURL = baseURL
    }

    // MARK: Coordinator lyfecycle
    func start() {
        let charactersService = CharactersService(baseURL: baseURL)
        self.viewModel = CharactersViewModel(
            service: charactersService
        )
    }

    func finish() {
        viewModel = nil
    }

    // MARK: Navigation
    @ViewBuilder
    func createView() -> some View {
        if let viewModel {
            NavigationStack {
                CharactersView(viewModel: viewModel)
            }
        }
    }
}

// MARK: Testhooks
#if DEBUG

extension CharactersCoordinator {
    var testHooks: TestHooks {
        return TestHooks(target: self)
    }

    struct TestHooks {
        private let target: CharactersCoordinator

        fileprivate init(target: CharactersCoordinator) {
            self.target = target
        }

        var viewModel: CharactersViewModel? {
            return target.viewModel
        }
    }
}

#endif

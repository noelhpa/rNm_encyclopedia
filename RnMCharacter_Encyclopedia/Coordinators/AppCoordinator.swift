//
//  AppCoordinator.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 5/31/25.
//

import Foundation
import SwiftUI

final class AppCoordinator: RMCoordinator, ObservableObject {

    // MARK: Public published properties
    @Published var isReady : Bool = false
    @Published var error: RMNetworkError?
    @Published var charactersCoordinator: CharactersCoordinator?

    var rootAPI: RootAPIResponseModel?

    // MARK: Private properties
    private let rootService: RootAPIServiceProtocol

    // MARK: Initialization
    init(rootService: RootAPIServiceProtocol = RootAPIService()){
        self.rootService = rootService
    }

    // MARK: Coordinator lifecycle
    func start() {
        Task {
            do {
                let rootAPIs = try await rootService.loadRootURLs()
                await MainActor.run {
                    self.rootAPI = rootAPIs
                    self.charactersCoordinator = CharactersCoordinator(
                        baseURL: rootAPIs.characters
                    )
                    charactersCoordinator?.start()
                    self.isReady = true
                }
            } catch let error as RMNetworkError {
                await MainActor.run {
                    self.error = error
                }
            }
        }
    }

    func finish() {
        charactersCoordinator = nil
        rootAPI = nil
        isReady = false
    }

    // MARK: Navigation
    @ViewBuilder
    func createView() -> some View {
        if let coordiator = charactersCoordinator {
            coordiator.createView()
        }
    }
}

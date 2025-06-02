//
//  ChractersCoordinatorTests.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 6/2/25.
//

import XCTest
@testable import RnMCharacter_Encyclopedia

final class ChractersCoordinatorTests: XCTestCase {
    private var coordinator: CharactersCoordinator!
    override func setUpWithError() throws {
        let url = "www.test.com"
        coordinator = CharactersCoordinator(baseURL: url)
    }

    override func tearDownWithError() throws {
        coordinator = nil
    }

    func testViewModelIsNotNilAtCoordinatorStart() {
        // When
        coordinator.start()

        // Then
        XCTAssertNotNil(coordinator.testHooks.viewModel)
    }

    func testViewModelIsNilAtCoordinatorFinish() {
        // When
        coordinator.finish()

        // Then
        XCTAssertNil(coordinator.testHooks.viewModel)
    }
}

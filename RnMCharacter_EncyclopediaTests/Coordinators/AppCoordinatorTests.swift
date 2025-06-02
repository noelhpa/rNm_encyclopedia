//
//  AppCoordinatorTests.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 6/2/25.
//

import XCTest
@testable import RnMCharacter_Encyclopedia

final class AppCoordinatorTests: XCTestCase {
    private var coordinator: AppCoordinator!
    private var service: RootAPIServiceMock!

    override func setUpWithError() throws {
        service = RootAPIServiceMock()
        coordinator = AppCoordinator(rootService: service)
    }

    override func tearDownWithError() throws {
        service = nil
        coordinator = nil
    }

    func testCoordinatorInitializeCorrectlyAndSetIsReadyToTrue() async throws {
        // When
        coordinator.start()
        try await Task.sleep(nanoseconds: 300_000_000)

        // Then
        await MainActor.run {
            XCTAssertTrue(coordinator.isReady)
            XCTAssertNotNil(coordinator.charactersCoordinator)
            XCTAssertNil(coordinator.error)
        }
    }

    func testCoordinatorFinishCorrectlyAndSetIsReadyToFalse() async throws {
        // When
        coordinator.finish()
        try await Task.sleep(nanoseconds: 300_000_000)

        // Then
        await MainActor.run {
            XCTAssertFalse(coordinator.isReady)
            XCTAssertNil(coordinator.charactersCoordinator)
            XCTAssertNil(coordinator.error)
        }
    }

    func testCoordinatorFailsToFechTheAPIAndThrowsNetworkError() async throws {
        // Given
        service.errorToThrow = .noInternetConnection
        coordinator = AppCoordinator(rootService: service)

        // When
        coordinator.start()
        try await Task.sleep(nanoseconds: 300_000_000)

        // Then
        await MainActor.run {
            XCTAssertFalse(coordinator.isReady)
            XCTAssertNil(coordinator.charactersCoordinator)
            XCTAssertEqual(coordinator.error, .noInternetConnection)
        }
    }
}

//
//  CharactersViewModelTests.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 6/2/25.
//

import XCTest
@testable import RnMCharacter_Encyclopedia

final class CharactersViewModelTests: XCTestCase {
    var viewModel: CharactersViewModel!
    var service: CharactersServiceMock!

    override func setUpWithError() throws {
        service = CharactersServiceMock()
        viewModel = CharactersViewModel(service: service)
    }

    override func tearDownWithError() throws {
        service = nil
        viewModel = nil
    }

    func testServiceIsNotNilOnInitialization() {
        XCTAssertNotNil(viewModel.testHooks.service)
        XCTAssertEqual(viewModel.state, .loading)
    }

    func testFetchedCharactersShouldEmitLoadedState() async throws {
        // Given
        let character = CharacterModel(
            id: 1,
            name: "Noel",
            status: "",
            species: "Human",
            type: "",
            gender: "Male",
            origin: .init(name: "", url: ""),
            location: .init(name: "SF", url: "www.test.com"),
            image: "",
            episode: [],
            url: "",
            created: ""
        )

        service.getAllCharactersResponse = CharacterResponseModel(
            info: InfoModel(count: 1, pages: 1, next: nil, prev: nil),
            results: [character]
        )
        let expectation = XCTestExpectation(description: "State should become .loaded")
        viewModel = CharactersViewModel(service: service)

        // When
        try await Task.sleep(nanoseconds: 300_000_000)

        await MainActor.run {
            switch viewModel.state {
            case .loaded(let characters, let lastId):
                XCTAssertEqual(characters.first?.id, character.id)
                XCTAssertEqual(lastId, character.id)
                expectation.fulfill()

            default:
                XCTFail("Test Failed: State should become .loaded")
            }
        }

        // Then
        await fulfillment(of: [expectation], timeout: 1.0)
    }

    func testFetchedCharactersShouldThrowANetworkError() async throws {
        // Given
        service = CharactersServiceMock()
        service.errorToThrow = .badRequest
        viewModel = CharactersViewModel(service: service)

        // When
        try await Task.sleep(nanoseconds: 200_000_000)

        // Then
        switch viewModel.state {
        case .error(error: let error):
            XCTAssertEqual(error, .badRequest)
        default:
            XCTFail("Test Failed: Expected state should be error .badRequest")
        }
    }

    func testLoadMoreCharactersShouldAppendNewCharactersAndEmitLoadedState() async throws {
        // Given
        let character1 = CharacterModel(
            id: 1,
            name: "Noel",
            status: "",
            species: "Human",
            type: "",
            gender: "Male",
            origin: .init(name: "", url: ""),
            location: .init(name: "SF", url: "www.test.com"),
            image: "",
            episode: [],
            url: "",
            created: ""
        )

        let character2 = CharacterModel(
            id: 2,
            name: "Jen",
            status: "",
            species: "Human",
            type: "",
            gender: "Girl",
            origin: .init(name: "", url: ""),
            location: .init(name: "SF", url: "www.test.com"),
            image: "",
            episode: [],
            url: "",
            created: ""
        )

        service.getAllCharactersResponse = CharacterResponseModel(
            info: .init(count: 2, pages: 2, next: "page=2", prev: nil),
            results: [character1]
        )
        viewModel = CharactersViewModel(service: service)

        try await Task.sleep(nanoseconds: 200_000_000)

        service.getAllCharactersResponse = CharacterResponseModel(
            info: .init(count: 2, pages: 2, next: nil, prev: "page=1"),
            results: [character2]
        )

        let expectation = XCTestExpectation(description: "Should append new characters")

        // When
        viewModel.loadMoreCharacters()
        try await Task.sleep(nanoseconds: 300_000_000)

        // Then
        await MainActor.run {
            switch viewModel.state {
            case .loaded(let characters, let lastId):
                XCTAssertEqual(characters.count, 2)
                XCTAssertEqual(characters[0].id, 1)
                XCTAssertEqual(characters[1].id, 2)
                XCTAssertEqual(lastId, 2)
                expectation.fulfill()
            default:
                XCTFail("Expected .loaded state after loading more characters")
            }
        }

        await fulfillment(of: [expectation], timeout: 1.0)
    }

}

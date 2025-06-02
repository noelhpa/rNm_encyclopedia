//
//  CharactersServiceMock.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 6/2/25.
//

@testable import RnMCharacter_Encyclopedia

final class CharactersServiceMock: CharactersServiceProtocol {
    var getAllCharactersResponse: CharacterResponseModel?
    var errorToThrow: RMNetworkError?

    func getCharacter(id: Int) async throws -> CharacterModel {
        return CharacterModel.empty
    }

    func getMultipleCharacters(ids: [Int]) async throws -> [CharacterModel] {
        return []
    }

    func getFilteredCharacters(name: String?, status: String?, species: String?) async throws -> CharacterResponseModel {
        return CharacterResponseModel.empty
    }

    func getAllCharacters(page: Int) async throws -> CharacterResponseModel {
        if let error = errorToThrow {
            throw error
        }
        return getAllCharactersResponse ?? CharacterResponseModel.empty
    }
}

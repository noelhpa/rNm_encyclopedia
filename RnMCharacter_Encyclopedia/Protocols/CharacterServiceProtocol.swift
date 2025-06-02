//
//  CharacterServiceProtocol.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 5/31/25.
//

import Foundation

protocol CharactersServiceProtocol {
    func getAllCharacters(page: Int) async throws -> CharacterResponseModel
    func getCharacter(id: Int) async throws -> CharacterModel
    func getMultipleCharacters(ids: [Int]) async throws -> [CharacterModel]
    func getFilteredCharacters(name: String?, status: String?, species: String?) async throws -> CharacterResponseModel
}

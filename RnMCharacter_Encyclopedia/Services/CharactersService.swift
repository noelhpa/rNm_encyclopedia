//
//  CharactersService.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 5/31/25.
//

import Foundation

final class CharactersService: CharactersServiceProtocol {
    private let baseURL: String

    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func getAllCharacters(page: Int) async throws -> CharacterResponseModel {
        guard let charactersAPIURL = URL(string: "\(baseURL)/?page=\(page)") else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: charactersAPIURL)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        do {
            let decoded = try JSONDecoder().decode(CharacterResponseModel.self, from: data)
            return decoded
        } catch {
            throw error
        }
    }
    
    func getCharacter(id: Int) async throws -> CharacterModel {
        // TODO: Implement later
        return CharacterModel.empty
    }
    
    func getMultipleCharacters(ids: [Int]) async throws -> [CharacterModel] {
        // TODO: Implement later
        return []
    }
    
    func getFilteredCharacters(name: String?, status: String?, species: String?) async throws -> CharacterResponseModel {
        // TODO: Implement later
        return CharacterResponseModel.empty
    }
}

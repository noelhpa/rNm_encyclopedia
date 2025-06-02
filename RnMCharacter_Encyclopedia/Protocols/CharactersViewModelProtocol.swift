//
//  CharactersViewModelProtocol.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 6/1/25.
//

import Foundation

protocol CharactersViewModelProtocol: ObservableObject {
    var state: CharactersViewStates { get }
    func fetchCharacters()
}

enum CharactersViewStates: Equatable {
    case loading
    case loaded(listOfCharacters: [CharacterModel], lastChracterId: Int?)
    case error(error: RMNetworkError)
}

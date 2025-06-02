//
//  CharacterResponseModel.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 5/31/25.
//

struct CharacterResponseModel: Codable {
    let info: InfoModel
    let results: [CharacterModel]
}

//
//  EmptyModelsExtensions.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 5/31/25.
//

extension InfoModel {
    static var empty: InfoModel {
        .init(count: 0, pages: 0, next: "", prev: "")
    }
}

extension CharacterResponseModel {
    static var empty: CharacterResponseModel {
        .init(info: .empty, results: [])
    }
}

extension OriginModel {
    static var empty: OriginModel {
        .init(name: "", url: "")
    }
}

extension LocationModel {
    static var empty: LocationModel {
        .init(name: "", url: "")
    }
}

extension CharacterModel {
    static var empty: CharacterModel {
        .init(id: 0, name: "", status: "", species: "", type: "", gender: "", origin: .empty, location: .empty, image: "", episode: [], url: "", created: "")
    }
}

extension RootAPIResponseModel {
    static var empty: RootAPIResponseModel {
        .init(characters: "", locations: "", episodes: "")
    }
}

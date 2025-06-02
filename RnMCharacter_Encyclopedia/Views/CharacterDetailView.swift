//
//  CharacterDetailView.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 6/1/25.
//

import SwiftUI

struct CharacterDetailView: View {
    private let character: CharacterModel

    // MARK: UIDimensions
    private let vStackSpacing: CGFloat = 12
    private let detailsFontSize: CGFloat = 16

    // MARK: Initialization
    init(character: CharacterModel) {
        self.character = character
    }

    // MARK: UIBody
    var body: some View {
        VStack(alignment: .leading, spacing: vStackSpacing) {
            detailRow(label: RMText.localized(key: "character_detail_status"), value: character.status)
            detailRow(label: RMText.localized(key: "character_detail_species"), value: character.species)
            detailRow(label: RMText.localized(key: "character_detail_gender"), value: character.gender)
            detailRow(
                label: RMText.localized(key: "character_detail_origin"),
                value: character.origin.name
            )
            detailRow(
                label: RMText.localized(key: "character_detail_location"),
                value: character.location.name
            )
        }
        .padding()
        .navigationTitle(character.name)
    }

    // MARK: Complementary accesory
    private func detailRow(label: String, value: String) -> some View {
        HStack {
            Text(label + ":")
                .fontWeight(.semibold)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
        .font(.system(size: detailsFontSize))
    }
}

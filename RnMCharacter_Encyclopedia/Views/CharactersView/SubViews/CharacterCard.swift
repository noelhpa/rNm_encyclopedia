//
//  CharacterCard.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 6/1/25.
//

import SwiftUI

struct CharacterCardView: View {
    let character: CharacterModel

    // MARK: UIDimensions
    private let cardCornerRadious: CGFloat = 12
    private let cardShadowRadius: CGFloat = 4
    private let characterNamePaddingTop: CGFloat = 8
    private let cardFrameHeight: CGFloat = 150
    private let cardImagePlaceholderOpacity: Double = 0.3

    // MARK: UIBody
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(cardImagePlaceholderOpacity)
            }
            .frame(height: cardFrameHeight)
            .clipped()
            .cornerRadius(cardCornerRadious)

            Text(character.name)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.top, characterNamePaddingTop)
        }
        .background(Color(.systemBackground))
        .cornerRadius(cardCornerRadious)
        .shadow(radius: cardShadowRadius)
    }
}

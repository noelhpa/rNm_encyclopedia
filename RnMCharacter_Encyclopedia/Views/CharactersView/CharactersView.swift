//
//  CharacterView.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 5/31/25.
//

import SwiftUI

struct CharactersView: View {
    @ObservedObject private var viewModel: CharactersViewModel
    @State private var selectedCharacter: CharacterModel?

    // MARK: UIDimensions
    private let spacingBetweenCards: CGFloat = 16

    // MARK: Initialization
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
    }

    // MARK: UIBody
    var body: some View {
        let columns = [
            GridItem(.flexible(), spacing: spacingBetweenCards),
            GridItem(.flexible(), spacing: spacingBetweenCards)
        ]

        ScrollView {
            switch viewModel.state {
            case .loading:
                ProgressView(RMText.localized(key: "loading"))

            case .loaded(let characters, let lastId):
                VStack {
                    LazyVGrid(columns: columns, spacing: spacingBetweenCards) {
                        ForEach(characters, id: \.id) { character in
                            CharacterCardView(character: character)
                                .onTapGesture {
                                    selectedCharacter = character
                                }
                                .onAppear {
                                    if character.id == lastId {
                                        viewModel.loadMoreCharacters()
                                    }
                                }
                        }
                    }
                    .padding()
                }

            case .error(let error):
                ErrorView(error: error) {
                    viewModel.fetchCharacters()
                }
            }
        }
        .navigationTitle(RMText.localized(key: "characters_title"))
        .sheet(item: $selectedCharacter) { character in
            NavigationStack {
                CharacterDetailView(character: character)
                    .presentationDetents([.medium])
            }
        }
    }
}

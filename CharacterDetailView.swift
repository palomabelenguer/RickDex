//
//  CharacterDetailView.swift
//  RickDex
//
//  Created by Paloma Belenguer on 25/8/25.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: character.image) { phase in
                    switch phase {
                    case .empty:
                        ZStack { ProgressView() }
                            .frame(height: 240)
                            .frame(maxWidth: .infinity)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 240)
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    case .failure:
                        Image(systemName: "person.fill.questionmark")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 160)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.secondary)
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    @unknown default:
                        EmptyView()
                    }
                }

                GroupBox {
                    LabeledContent("Name", value: character.name)
                    Divider()
                    LabeledContent("Species", value: character.species)
                    Divider()
                    LabeledContent("Status", value: character.status)
                    Divider()
                    LabeledContent("Gender", value: character.gender)
                    Divider()
                    LabeledContent("Origin", value: character.origin.name)
                    Divider()
                    LabeledContent("Last seen", value: character.location.name)
                }
                .groupBoxStyle(.automatic)
            }
            .padding()
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


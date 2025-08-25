//
//  CharacterRowView.swift
//  RickDex
//
//  Created by Paloma Belenguer on 25/8/25.
//

import SwiftUI

// CLEAN: Vista pequeña y enfocada
struct CharacterRowView: View {
    let character: Character

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: character.image) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 56, height: 56)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 56, height: 56)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                case .failure:
                    Image(systemName: "person.fill.questionmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 56, height: 56)
                        .foregroundStyle(.secondary)
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(character.name)
                    .font(.headline)
                Text("\(character.species) • \(character.status)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 6)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(character.name), \(character.species), \(character.status)")
    }
}


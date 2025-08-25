//
//  CharacterListView.swift
//  RickDex
//
//  Created by Paloma Belenguer on 25/8/25.
///// Lista principal de personajes.
///  Muestra loading inicial, error con retry y paginación; navega a detalle.
import SwiftUI

struct CharacterListView: View {
    @StateObject var viewModel: CharacterListViewModel
    @EnvironmentObject private var network: NetworkMonitor   // para mostrar el banner Offline

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                content                                         // contenido según estado
                if !network.isConnected {
                    OfflineBanner()                             // mensaje amistoso si no hay red
                        .transition(.move(edge: .top))
                }
            }
            .navigationTitle("RickDex")
        }
        .task {
            // CLEAN: Evitar llamadas duplicadas; solo cargamos si está idle
            if viewModel.state == .idle {
                await viewModel.load()
            }
        }
    }

    // MARK: - Content (estados)
    // CLEAN: sin `where` en los `case` para evitar el warning; usamos ifs dentro.
    @ViewBuilder private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            if viewModel.characters.isEmpty {
                // Feedback al usuario mientras se hace fetch inicial
                ProgressView("Loading characters…")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                list
            }

        case .failed(let error):
            if viewModel.characters.isEmpty {
                // Error legible + retry si la primera carga falla
                ErrorStateView(
                    message: error.errorDescription ?? "Error",
                    retry: { await viewModel.retry() }
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            } else {
                // Si ya había datos y falla la siguiente página, mantenemos la lista
                list
            }

        case .loaded:
            list
        }
    }

    // MARK: - Lista + paginación + navegación a detalle
    private var list: some View {
        List {
            ForEach(viewModel.characters) { character in
                NavigationLink(value: character) {
                    CharacterRowView(character: character)     // vista pequeña y reutilizable
                }
            }

            // Paginación: spinner al final y dispara siguiente carga
            if viewModel.hasMore {
                HStack {
                    Spacer()
                    ProgressView()
                        .task { await viewModel.load() }
                    Spacer()
                }
            }
        }
        .listStyle(.plain)
        .navigationDestination(for: Character.self) { character in
            CharacterDetailView(character: character)
        }
    }
}

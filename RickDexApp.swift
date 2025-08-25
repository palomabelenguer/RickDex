//
//  RickDexApp.swift
//  RickDex
//
//  Created by Paloma Belenguer on 25/8/25.
//

import SwiftUI

@main
struct RickDexApp: App {
    @StateObject private var networkMonitor = NetworkMonitor()

    var body: some Scene {
        WindowGroup {
            CharacterListView(viewModel: CharacterListViewModel())
                .environmentObject(networkMonitor)
        }
    }
}

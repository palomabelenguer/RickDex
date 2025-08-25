//
//  SharedViews.swift
//  RickDex
//
//  Created by Paloma Belenguer on 25/8/25.
//

import SwiftUI

struct ErrorStateView: View {
    let message: String
    let retry: () async -> Void

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 32))
                .foregroundStyle(.secondary)
            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
            Button(action: { Task { await retry() } }) {
                Label("Try Again", systemImage: "arrow.clockwise")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

struct OfflineBanner: View {
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "wifi.slash")
            Text("Offline")
                .font(.subheadline)
                .bold()
            Text("Some features may not work.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer()
        }
        .padding(12)
        .background(.yellow.opacity(0.2))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.yellow, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding()
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Offline. Some features may not work.")
    }
}


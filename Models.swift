//
//  Models.swift
//  RickDex
//
//  Created by Paloma Belenguer on 25/8/25.
//

import Foundation

struct CharacterResponse: Decodable {
    let info: PageInfo
    let results: [Character]
}

struct PageInfo: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: URL
    let origin: LocationRef
    let location: LocationRef
}

struct LocationRef: Decodable, Hashable {
    let name: String
    let url: String
}

// CLEAN: Superficie de error pequeña y expresiva
enum APIError: LocalizedError, Equatable {
    case noConnection
    case invalidURL
    case badStatus(code: Int)
    case decoding
    case transport(URLError)
    case unknown

    var errorDescription: String? {
        switch self {
        case .noConnection:
            return "No connection. Please try again."
        case .invalidURL:
            return "Invalid request."
        case .badStatus(let code):
            return "Request failed (code: \(code))."
        case .decoding:
            return "Could not read server response."
        case .transport(let urlError):
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost:
                return "No connection. Please try again."
            case .timedOut:
                return "The request timed out."
            default:
                return "Network error: \(urlError.localizedDescription)"
            }
        case .unknown:
            return "Something went wrong."
        }
    }
}


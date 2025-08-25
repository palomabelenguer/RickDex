//
//  APIService.swift
//  RickDex
//
//  Created by Paloma Belenguer on 25/8/25.
//

import Foundation

// CLEAN: Una sola responsabilidad (fetch characters); API simple y componible
protocol CharactersServicing {
    func fetchCharacters(page: Int) async throws -> CharacterResponse
}

struct RickAndMortyAPI: CharactersServicing {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchCharacters(page: Int) async throws -> CharacterResponse {
        guard var components = URLComponents(string: "https://rickandmortyapi.com/api/character") else {
            throw APIError.invalidURL
        }
        components.queryItems = [URLQueryItem(name: "page", value: String(page))]
        guard let url = components.url else { throw APIError.invalidURL }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let (data, response) = try await session.data(for: request)
            guard let http = response as? HTTPURLResponse else { throw APIError.unknown }
            guard (200..<300).contains(http.statusCode) else { throw APIError.badStatus(code: http.statusCode) }

            do {
                return try JSONDecoder().decode(CharacterResponse.self, from: data)
            } catch {
                throw APIError.decoding
            }
        } catch let urlError as URLError {
            throw APIError.transport(urlError)
        } catch {
            throw APIError.unknown
        }
    }
}


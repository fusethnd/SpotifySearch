//
//  SearchManager.swift
//  SpotifySearch
//
//  Created by Thanadon Boontawee on 14/3/2567 BE.
//

import Foundation

class SearchManager {
    static let shared = SearchManager()

    func searchSpotify(query: String, completion: @escaping (Result<[Track], Error>) -> Void) {
        ModelData.searchSpotify(filePath: query) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Unknown error", code: -1, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let searchResult = try decoder.decode(TrackSearchResult.self, from: data)
                completion(.success(searchResult.tracks))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func fetch () {
        guard let url = URL(string: "https://api.yourdomain.com/endpoint") else {
            print("Invalid URL")
            return
        }

    }
}

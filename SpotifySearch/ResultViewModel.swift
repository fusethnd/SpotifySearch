//
//  TrackViewModel.swift
//  SpotifySearch
//
//  Created by Thanadon Boontawee on 14/3/2567 BE.
//

import Foundation

class ResultViewModel: ObservableObject {
    // @Published var trackURLs: [String] = []
    @Published var trackURIs: [String] = [] // URL -> URI
    @Published var firstTrackURI = ""
    @Published var isLoading = false
    @Published var message = ""

    func fetchData(keyword: String, type: String) {
        guard !keyword.isEmpty, !type.isEmpty else {
            self.message = "Keyword or type cannot be empty."
            return
        }

        isLoading = true
        let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://spotify117.p.rapidapi.com/search/?keyword=\(encodedKeyword)&type=\(type)"

        guard let url = URL(string: urlString) else {
            self.message = "Invalid URL"
            isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "X-RapidAPI-Key": "f34c28b1f7msh7a0baf86b094b37p13df52jsn498ecff72d7f",
            "X-RapidAPI-Host": "spotify117.p.rapidapi.com"
        ]

        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                self?.isLoading = false
            }

            if let error = error {
                DispatchQueue.main.async {
                    self?.message = "Error: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self?.message = "No data received."
                }
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(TracksResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.trackURIs = decodedData.tracks.items.map { $0.uri } // { $0.external_urls.spotify }
                    if let firstURI = self?.trackURIs.first {
                        print("First track URI: \(firstURI)") // Print the first track URI
                        self?.firstTrackURI = firstURI // Also store it in firstTrackURI
                    } else {
                        self?.message = "No results found."
                        print("No track URIs found.")
                    }
                    print("Track URIs: \(self?.trackURIs ?? [])") // Print the track URIs
                }
            } catch {
                DispatchQueue.main.async {
                    self?.message = "Decoding error: \(error.localizedDescription)"
                }
            }
            
        }.resume()
    }
}

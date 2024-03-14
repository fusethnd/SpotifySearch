//
//  TrackViewModel.swift
//  SpotifySearch
//
//  Created by Thanadon Boontawee on 14/3/2567 BE.
//

import Foundation

class TrackViewModel: ObservableObject {
    @Published var tracks: [Track] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var firstAlbumData: AlbumData?
    
    func search(query: String) {
        isLoading = true
        // This is a placeholder for calling your actual search method
        // Replace with your actual search logic
        SearchManager.shared.searchSpotify(query: query) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let tracks):
                    self?.tracks = tracks
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchFirstAlbum() {
        let urlString = "https://api.yourdomain.com/endpoint" // Replace with your actual API endpoint
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let albumResponse = try JSONDecoder().decode(AlbumResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.firstAlbumData = albumResponse.albums.items.first?.data
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}

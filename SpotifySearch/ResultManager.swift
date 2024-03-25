//
//  ResultManager.swift
//  SpotifySearch
//
//  Created by Thanadon Boontawee on 14/3/2567 BE.
//

import Foundation

struct TracksResponse: Decodable {
    let tracks: TrackList
}

struct TrackList: Decodable {
    let items: [TrackItem]
}

struct TrackItem: Decodable {
    let external_urls: ExternalURLs
}

struct ExternalURLs: Decodable {
    let spotify: String
}


//
//  ResultManager.swift
//  SpotifySearch
//
//  Created by Thanadon Boontawee on 2/5/2567 BE.
//

import Foundation

struct TracksResponse: Decodable {
    let tracks: TrackList
}

struct TrackList: Decodable {
    let items: [TrackItem]
}

//struct TrackItem: Decodable, Identifiable {
////    let uri: String
//    let id: String
//    let name: String
////    let artist: String
////    let imageURL: String
//    let previewURL: String
//}
//
////struct ExternalURLs: Decodable {
////    let spotify: String
////}

struct TrackItem: Decodable, Identifiable {
    let id: String
    let name: String
    let artists: [Artist]  // Assuming this structure exists in your JSON
    let album: Album  // Assuming this structure exists in your JSON
    let previewURL: URL // String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case artists
        case album
        case previewURL = "preview_url"  // Assuming JSON has "preview_url"
    }
    
    // To access the artist name and image URL, you can add computed properties:
    var artist: String {
        artists.first?.name ?? "Unknown Artist"
    }
    
    var imageURL: String {
        album.images.first?.url ?? ""
    }
}

struct Artist: Decodable {
    let name: String
}

struct Album: Decodable {
    let images: [AlbumImage]
}

struct AlbumImage: Decodable {
    let url: String
}

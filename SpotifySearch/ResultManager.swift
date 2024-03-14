//
//  ResultManager.swift
//  SpotifySearch
//
//  Created by Thanadon Boontawee on 14/3/2567 BE.
//

import Foundation

struct TrackSearchResult: Decodable {
    let tracks: [Track]
}

struct Track: Identifiable, Decodable {
    var id: String  // Unique identifier, needed for Identifiable
    var name: String
    var artist: String
    var album: String
    var previewUrl: String?
    
    // Define coding keys if your model property names don't match the JSON keys
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case artist
        case album
        case previewUrl = "preview_url"
    }
}

struct AlbumResponse: Decodable {
    let albums: AlbumList
}

struct AlbumList: Decodable {
    let totalCount: Int
    let items: [Album]
}

struct Album: Decodable {
    let data: AlbumData
}

struct AlbumData: Decodable {
    let uri: String
    let name: String
    let artists: ArtistList
    let coverArt: CoverArt
    let date: ReleaseDate
}

struct ArtistList: Decodable {
    let items: [Artist]
}

struct Artist: Decodable {
    let uri: String
    let profile: ArtistProfile
}

struct ArtistProfile: Decodable {
    let name: String
}

struct CoverArt: Decodable {
    let sources: [ImageSource]
}

struct ImageSource: Decodable {
    let url: String
    let width: Int
    let height: Int
}

struct ReleaseDate: Decodable {
    let year: Int
}


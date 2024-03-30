//
//  TrackViewModel.swift
//  SpotifySearch
//
//  Created by Thanadon Boontawee on 28/3/2567 BE.
//

import Foundation
import AVFoundation

class TrackViewModel: ObservableObject {
    @Published var isPlaying = false
    private var player: AVPlayer?

//    let url = "https://p.scdn.co/mp3-preview/4fd5a6687c3599398218d81849cdda23159e1d2d?cid=d8a5ed958d274c2e8ee717e6a4b0971d"

    init() {
        setupPlayer()
    }

    private func setupPlayer() {
        // let url = "https://p.scdn.co/mp3-preview/4fd5a6687c3599398218d81849cdda23159e1d2d?cid=d8a5ed958d274c2e8ee717e6a4b0971d"
        let url = "https://p.scdn.co/mp3-preview/cc29d9131c126ac5362dcddad9aa89b3afe1f086?cid=09fdf7e9e0a14b9b9578d3dde7f9c444"
        guard let url = URL(string: url) else { return }
        player = AVPlayer(url: url)
    }

    func togglePlayPause() {
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying.toggle()
    }
}

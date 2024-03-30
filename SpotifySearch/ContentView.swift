//
//  ContentView.swift
//  SpotifySearch
//
//  Created by Thanadon Boontawee on 14/3/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ResultViewModel()
    @State private var keyword = ""
    @State private var selectedType = "track"  // Assuming you're searching for tracks

    @StateObject var trackViewModel = TrackViewModel()
    // @StateObject var trackViewModel = [:]
    // Dictionary to hold view models for each URI

    var body: some View {
        VStack {
            TextField("Keyword", text: $keyword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Search") {
                viewModel.fetchData(keyword: keyword, type: selectedType)
            }
            .padding()

            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.trackURIs.isEmpty {
                Text(viewModel.message)
            } else {
                Text(viewModel.firstTrackURI)
                // Get url p.... by Spotify api
                // use firstTrackURI as input and get url p.... by Spotify api
                VStack {
                    Button(action: {
                        trackViewModel.togglePlayPause()
                    }) {
                        Image(systemName: trackViewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

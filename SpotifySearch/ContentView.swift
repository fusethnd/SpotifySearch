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
   
    var body: some View {
        VStack {
            HStack {
                TextField("Find your music", text: $keyword)
                    .frame(width: 260)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Search") {
                    viewModel.fetchData(keyword: keyword, type: selectedType)
                }
                .padding()
            }
            
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.result.isEmpty {
                Text(viewModel.message).foregroundColor(.red)
            } else {
                NavigationView { // maybe take this out
                    VStack { // maybe take this out
                        List(viewModel.result) { item in
                            TrackItemView(item: item)
                        }
                        .listStyle(PlainListStyle())
                    }
                    .navigationTitle("Result")
                    .toolbar {
                        Button {
                            // To previous page (Locations)
                        } label: {
                            Image(systemName: "<")
                        }
                        
                        Button {
                            // To the next page (CreateNewPost)
                        } label: {
                            Text("Next")
                        }
                    }
                }
                
//                List(viewModel.trackID, id: \.self) { id in
//                    Text(id)
//                    // TrackItemView(id)
//                }
//                Text(viewModel.firstTrackURI)
                // Get url p.... by Spotify api
                // use firstTrackURI as input and get url p.... by Spotify api
                
//                VStack {
//                    Button(action: {
//                        trackViewModel.togglePlayPause()
//                    }) {
//                        Image(systemName: trackViewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 50, height: 50)
//                    }
//                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

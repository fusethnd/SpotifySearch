//
//  ContentView.swift
//  SpotifySearch
//
//  Created by Thanadon Boontawee on 14/3/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @StateObject private var viewModel = TrackViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("")
                // Search text field with padding and clear button
                HStack {
                    TextField("Search for a song", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.webSearch)
                        .submitLabel(.search)
                        .onSubmit {
                            viewModel.search(query: searchText) // Search when the return key is tapped
                        }

                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding()

                // Search button
                Button("Search") {
                    hideKeyboard()
                    viewModel.search(query: searchText)
                }
                .padding()

                // Content based on the state
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage, !errorMessage.isEmpty {
                    Text(errorMessage)
                } else if viewModel.tracks.isEmpty && !viewModel.isLoading {
                    Text("No results found").foregroundColor(.gray)
                } else {
                    List(viewModel.tracks, id: \.id) { track in
                        VStack(alignment: .leading) {
                            Text(track.name).bold()
                            Text(track.artist).font(.subheadline).foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationBarTitle("Spotify Song Search")
        }
        
        VStack {
            if let albumData = viewModel.firstAlbumData {
                Text("Album: \(albumData.name)")
                Text("Artist: \(albumData.artists.items.first?.profile.name ?? "Unknown")")
                // Add more details as needed...
            } else {
                Text("Loading or no album data available")
            }
        }
        .onAppear {
            viewModel.fetchFirstAlbum() // Fetch the album data when the view appears
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

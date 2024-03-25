//
//  ContentView.swift
//  SpotifySearch
//
//  Created by Thanadon Boontawee on 14/3/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = TrackViewModel()
    @State private var keyword = ""
    @State private var selectedType = "track"  // Assuming you're searching for tracks

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
            } else if viewModel.trackURLs.isEmpty {
                Text(viewModel.message)
            } else {
                List(viewModel.trackURLs, id: \.self) { url in
                    Text(url)
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

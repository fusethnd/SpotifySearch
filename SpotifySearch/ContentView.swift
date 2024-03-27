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
//                List(viewModel.trackURIs, id: \.self) { uri in
//                    Text(uri)
//                }
                Text(viewModel.firstTrackURI)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

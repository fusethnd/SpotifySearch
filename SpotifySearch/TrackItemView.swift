//
//  TrackItemView.swift
//  SpotifySearch
//
//  Created by Thanadon Boontawee on 26/4/2567 BE.
//

import SwiftUI

struct TrackItemView: View {
//    @StateObject var viewModel = TrackItemViewModel()
    // let item: TrackItem
    // @StateObject var trackViewModel = TrackViewModel(item: TrackItem)
    @ObservedObject var trackViewModel: TrackViewModel
    
    
    init(item: TrackItem) {
        self.trackViewModel = TrackViewModel(item: item)
        //self.item = item
    }
    
    var body: some View {
        HStack {
            // Image
            if let imageURL = URL(string: trackViewModel.getImageURL()) {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        Image(systemName: "photo.circle") // Placeholder while loading
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()
                    case .failure:
                        Image(systemName: "person.circle") // Displayed in case of failure
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "person.circle") // Displayed if URL is nil
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding()
            }
            
            VStack(alignment: .leading) {
                Text(trackViewModel.getName())
                    .font(.title3)
                    .bold()
                
                Text(trackViewModel.getArtist())
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            
            Spacer()
            
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


// Cannot preview since cannnot find artists data and album data to put here for all

//struct TrackItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackItemView(item: TrackItem(
//            id: "69ybwJj0gIujut2fiIMQLY",
//            name: "พี่ชอบหนูที่สุดเลย",
//            artist: "PONCHET",
//            imageURL: "https://i.scdn.co/image/ab67616d0000b273c4ef9bcc66527ca4a1055b73"
//            previewURL: "https://p.scdn.co/mp3-preview/4fd5a6687c3599398218d81849cdda23159e1d2d?cid=09fdf7e9e0a14b9b9578d3dde7f9c444"
//            )
//        )
//    }
//}

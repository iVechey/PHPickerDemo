//
//  ItemsView.swift
//  PHPickerDemo
//
//  Created by Gabriel Theodoropoulos.
//

import SwiftUI
import AVKit // this is for playing a video: might not need

struct ItemsView: View {
    @State private var showSheet = false
    @ObservedObject var mediaItems = PickedMediaItems()
    
    var body: some View {
        NavigationView {
            EmptyView()
                .navigationBarItems(leading: Button(action: {
                    
                }, label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }), trailing: Button(action: {
                    showSheet = true
                }, label: {
                    Image(systemName: "plus")
                }))
        }
        .sheet(isPresented: $showSheet, content: {
            PhotoPicker(mediaItems: mediaItems) { didSelectItems in
                           
                showSheet = false
            }         
        })
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        List(mediaItems.items, id: \.id) {item in
            if item.mediaType == .photo {                              
                Image(uiImage: item.photo ?? UIImage()) //if a photo, show it, if not show an empty UIImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)                          
        
            } else if item.mediaType == .video {
                if let url = item.url {
                    VideoPlayer(player: AVPlayer(url: url))
                    .frame(minHeight: 200)
                } else { EmptyView() }
            } else {
                if let livePhoto = item.livePhoto {
                    LivePhotoView(livePhoto: livePhoto)
                        .fram(meinHeight: 200)
                } else { EmptyView() }
                
            }
                
        }
    }
}

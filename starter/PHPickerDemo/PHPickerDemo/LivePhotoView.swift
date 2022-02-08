//
//  LivePhotoView.swift
//  PHPickerDemo
//
//  Created by Gabriel Theodoropoulos.
//

import SwiftUI
import PhotosUI

struct LivePhotoView: UIViewRepresentable {
  var livePhoto: PHLivePhoto
  typealias UIViewType = PHLivePhotoView
  
  func makeUIView(context: Context) -> PHLivePhotoView {
    let livePhotoView = PHLivePhotoView()
    livePhotoView.livePhoto = livePhoto
    livePhotoView.startPlayback(with: .hint) //this will tell user that this is a live photo
    return livePhotoView
  }
  
  func updateUIView(_ uiView: PHLivePhotoView, context: Context) { //necessary to have but don't need anything in the function
    
  }
}

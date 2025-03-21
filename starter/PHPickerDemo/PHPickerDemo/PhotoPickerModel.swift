//
//  PhotoPickerModel.swift
//  PHPickerDemo
//
//  Created by Gabriel Theodoropoulos.
//

import SwiftUI
import Photos

struct PhotoPickerModel: Identifiable {
  enum MediaType {
    case photo, video, livePhoto
  }
  var id: String
  var photo: UIImage? 
  var url: URL? 
  var livePhoto: PHLivePhoto? 
  var mediaType: MediaType = .photo
  
  init(with photo: UIImage) {
    id = UUID().uuidString
    self.photo = photo
    mediaType = .photo
  }
  init(with videoURL: URL) {
    id = UUID().uuidString
    url = videoURL
    mediaType = .video
  }
 
  init(with livePhoto: PHLivePhoto) {
    id = UUID().uuidString
    self.livePhoto = livePhoto
    mediaType = .livePhoto
  }
}

class PickedMediaItems: ObservableObject {
  @Published var items = [PhotoPickerModel]()  
  
  func append(item: PhotoPickerModel) { //use this method for taking a photo as well
    items.append(item)  
  } 
  
  mutating func delete() {
    switch mediaType {
      case .photo: photo = nil
      case .livePhoto: livePhoto = nil
      case .video: 
        guard let url = url else { return }
        try? FileManager.default.removeItem(at: url)
        self.url = nil
    }
}


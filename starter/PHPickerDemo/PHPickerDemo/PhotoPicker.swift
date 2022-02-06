//
//  PhotoPicker.swift
//  PHPickerDemo
//
//  Created by Gabriel Theodoropoulos.
//

import SwiftUI
import PhotosUI


struct PhotoPicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = PHPickerViewController
  
  
 
    func makeUIViewController(context: Context) -> PHPickerViewController {
      var config = PHPickerConfiguration()
      config.filter = .images
      config.selectionLimit = 20
      config.preferredAssetRepresentationMode = .current
      
      let controller = PHPickerViewController(configuration: config)
      controller.delegate = context.coordinator
      return controller
    }
 
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
      
    }
  
    func makeCoordinator() -> Coordinator {
      Coordinator(with: self) 
    }
  
    class Coordinator {
      var photoPicker: PhotoPicker
      
      init(with photoPicker: PhotoPicker) {
        self.photoPicker = photoPicker 
      }
      
    }
}



//
//  PhotoPicker.swift
//  PHPickerDemo
//
//  Created by Gabriel Theodoropoulos.
//

import SwiftUI
import PhotosUI


struct PhotoPicker: UIViewControllerRepresentable {
    var didFinishPicking(_ didSelectItems: Bool) -> Void
    typealias UIViewControllerType = PHPickerViewController
  
  
 
    func makeUIViewController(context: Context) -> PHPickerViewController {
      var config = PHPickerConfiguration()
      config.filter = .images
      config.selectionLimit = 20 //selection limit: may not need
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
  
    class Coordinator: PHPickerViewControllerDelegate {
      var photoPicker: PhotoPicker
      
      init(with photoPicker: PhotoPicker) {
        self.photoPicker = photoPicker 
      }
      
      func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) { //results are the photos selected
          photoPicker.didFinishPicking(!results.isEmpty)
          
          guard !results.isEmpty else {
              return
          }
      }
    }
}



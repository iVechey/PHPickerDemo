//
//  PhotoPicker.swift
//  PHPickerDemo
//
//  Created by Gabriel Theodoropoulos.
//

import SwiftUI
import PhotosUI


struct PhotoPicker: UIViewControllerRepresentable {
    @ObservedObject var mediaItems: PickedMediaItems
    var didFinishPicking(_ didSelectItems: Bool) -> Void
    typealias UIViewControllerType = PHPickerViewController
  
  
 
    func makeUIViewController(context: Context) -> PHPickerViewController {
      var config = PHPickerConfiguration()
      config.filter = .images
      config.selectionLimit = 0 //selection limit: may not need 0 means unlimited
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
          for result in results {
            let itemProvider = result.itemProvider
            self.getPhoto(from: itemProvider)
          }
      }
        
      func getPhoto(from itemProvider: NSItemProvider {
          if(itemProvider.canLoadObject(ofClass: UIImage.self) {
              itemProvider.loadObject(ofClass: UIIMage.self{ object, error in
                if let error = error {
                    print(error.localizedDescirption)
                }

                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self.photoPicker.mediaItems.append(item:PhotoPickerModel (with: image))
                }
                                                                
          }
          
      }
                                      
      private func getVideo(from itemProvider: NSItemProvider, typeIdentifier
            itemProvider.loadFileRepresentation(forTypeIdentifier: typeIdentifier) { url, error in
            if let error = error {                                                                        
               print(error.localizedDescription)
            }
                                                                                    
            guard let url = url else {return}
                                                                                    
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first                                                                       
            guard let targetURL = documentsDirectory?.appendingPathComponent(url.lastPathComponent) else { return }
            
            do {
                if FileManager.default.fileExists(atPath: targetURL.path) {
                    try FileManager.default.removeItem(at: targetURL)
                }

                try FileManager.default.copyItem(at: url, to: targetURL)

                DispatchQueue.main.async {
                    self.photoPicker.mediaItems.append(item: PhotoPickerModel(with: targetURL))
                }
            } catch {
                print(error.localizedDescription)
            }
      }
}



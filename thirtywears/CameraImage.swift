//
//  CameraImage.swift
//  thirtywears
//
//  Created by Penelope Labram on 15/4/21.
//

import SwiftUI
import Combine

struct CameraImage: UIViewControllerRepresentable {
    @Binding var show: Bool
    @Binding var image: Data
    
    func makeCoordinator() -> CameraImage.CameraCoordinator {
        return CameraImage.CameraCoordinator(child1: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraImage>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CameraImage>) {

    }
    
    class CameraCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var child : CameraImage
        init(child1: CameraImage) {
            child = child1
        }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.child.show.toggle()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage]as! UIImage
        let data = image.jpegData(compressionQuality: 0.45)
        self.child.image = data!
        self.child.show.toggle()
    }
}
}

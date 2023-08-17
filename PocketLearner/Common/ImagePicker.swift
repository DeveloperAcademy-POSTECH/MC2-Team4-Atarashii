//
//  ImagePicker.swift
//  PocketLearner
//
//  Created by 주환 on 2023/05/09.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        @Binding var presentationMode: PresentationMode
        @Binding var selectedImage: UIImage?
        
        init(presentationMode: Binding<PresentationMode>, selectedImage: Binding<UIImage?>) {
            _presentationMode = presentationMode
            _selectedImage = selectedImage
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else { return }
            selectedImage = image
            presentationMode.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, selectedImage: $selectedImage)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
}

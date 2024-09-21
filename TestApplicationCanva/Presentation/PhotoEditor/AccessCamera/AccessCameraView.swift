//
//  AccessCameraView.swift
//  TestApplicationCanva
//
//  Created by Андрей Банин on 21.9.24..
//

import SwiftUI

struct AccessCameraView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
        
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }

    func makeCoordinator() -> CoordinatorPicker {
        return CoordinatorPicker(picker: self)
    }
}

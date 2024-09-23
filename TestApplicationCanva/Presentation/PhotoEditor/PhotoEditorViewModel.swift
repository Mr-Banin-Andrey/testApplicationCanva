//
//  PhotoEditorViewModel.swift
//  TestApplicationCanva
//
//  Created by Андрей Банин on 20.9.24..
//

import SwiftUI

final class PhotoEditorViewModel: ObservableObject {
        
//    @Published var selectedImage: UIImage?
    @Published var selectedImageData: Data?
    
    @Published var rotation = 0.0
    
    func cancel() {
        selectedImageData = nil
    }
    
    func imageRotation() {
        rotation += 90
    }
    
    func initialPositionImage() {
        rotation = 0.0
    }
}

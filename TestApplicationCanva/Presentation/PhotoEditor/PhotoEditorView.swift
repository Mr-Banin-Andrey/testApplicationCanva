//
//  PhotoEditorView.swift
//  TestApplicationCanva
//
//  Created by Андрей Банин on 20.9.24..
//

import SwiftUI
import PhotosUI

struct PhotoEditorView: View {
    @StateObject var viewModel: PhotoEditorViewModel
    
    @State var selectedItem: PhotosPickerItem?
        
    var body: some View {
        VStack {
            Text("Hello, World!")
            
            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()
            ) {
                Text("Open library")
            }
            .onChange(of: selectedItem) { _, newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        viewModel.selectedImageData = data
                    }
                }
            }
            
            if let image = viewModel.selectedImageData, let uiImage = UIImage(data: image) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
        }
    }
}

#Preview {
    PhotoEditorView(viewModel: PhotoEditorViewModel())
}

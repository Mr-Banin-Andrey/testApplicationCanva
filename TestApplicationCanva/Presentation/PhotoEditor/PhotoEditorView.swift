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

    @State private var selectedItem: PhotosPickerItem?
    @State private var showCamera: Bool = false
    @State private var rotation = 0.0
    @State private var scale = 0.0
    
    var body: some View {
        VStack {
            if let image = viewModel.selectedImageData {
                VStack{
                    ZStack {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width, height: 400)
                            .scaleEffect(1 + scale)
                            .gesture(
                                MagnificationGesture()
                                    .onChanged({ value in
                                        scale = value - 1
                                    })
                                    .onEnded({ value in
                                        withAnimation(.spring) {
                                            scale = 0
                                        }
                                    })
                            )
                    }
                    .rotationEffect(.degrees(rotation))
                }
                .rotated()
                
                HStack {
                    Button {
                        withAnimation {
                            rotation += 90.0
                        }
                    } label: {
                        VStack {
                            Image(systemName: "rotate.right")
                                .foregroundStyle(Color.purple)
                            
                            Text("Повернуть")
                                .foregroundStyle(Color.purple)
                        }
                    }
                }
                .padding(.top, 16)
            }
            
            VStack {
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Text("Open gallery")
                        .foregroundStyle(Color.black)
                }
                .onChange(of: selectedItem) { _, newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            rotation = 0.0
                            withAnimation {
                                viewModel.selectedImageData = UIImage(data: data)
                                selectedItem = nil
                            }
                        }
                    }
                }
                .padding(10)
                .background(Color.orange)
                .cornerRadius(12)
                
                Button {
                    self.showCamera.toggle()
                    if viewModel.selectedImageData != nil {
                        rotation = 0.0
                    }
                } label: {
                    Text("Open camera")
                        .foregroundStyle(Color.black)
                }
                .fullScreenCover(isPresented: self.$showCamera) {
                    AccessCameraView(selectedImage: $viewModel.selectedImageData)
                }
                .padding(10)
                .background(Color.purple)
                .cornerRadius(12)
            }
        }
    }
}

#Preview {
    PhotoEditorView(viewModel: PhotoEditorViewModel())
}

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
        NavigationView {
            VStack {
//            if let imageData = viewModel.selectedImageData, let uiImage = UIImage(data: imageData) {
                VStack {
                    ZStack {
                        Image(uiImage: (UIImage(data: viewModel.selectedImageData ?? Data()) ?? UIImage(named: "mockImage")) ?? UIImage())
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
                .padding(.top, 24)
                
                /// кнопка поворота картинки
//                    Button {
//                        withAnimation {
//                            rotation += 90.0
//                        }
//                    } label: {
//                        VStack {
//                            Image(systemName: "rotate.right")
//                                .foregroundStyle(Color.purple)
//                            
//                            Text("Повернуть")
//                                .foregroundStyle(Color.purple)
//                        }
//                    }
//                .padding(.top, 16)
                
//                Button {

                    //TODO: открывается sheet и там редактируется изобоажение
                    NavigationLink {
                        EditingImageView(imageData: viewModel.selectedImageData ?? Data())
                    } label: {
                        HStack {
                            Image(systemName: "square.and.pencil")

                            Text("Редактирование")
                        }
                        .foregroundStyle(Color.purple)
                    }

//                } label: {
//                    
//                }
                .padding(16)

                VStack {
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        HStack {
                            Image(systemName: "photo.on.rectangle")
                            
                            Text("Открыть галерею")
                        }
                        .font(.title3)
                        .foregroundStyle(Color.black)
                        .padding(10)
                        .background(Color.orange.opacity(0.5))
                        .cornerRadius(12)
                        
                    }
                    .onChange(of: selectedItem) { _, newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                rotation = 0.0
                                withAnimation {
//                                    viewModel.selectedImage = UIImage(data: data)
                                    viewModel.selectedImageData = data
                                    selectedItem = nil
                                }
                            }
                        }
                    }
                    
                    Button {
                        self.showCamera.toggle()
                        if viewModel.selectedImageData != nil {
                            rotation = 0.0
                        }
                    } label: {
                        HStack {
                            Image(systemName: "camera")
                            
                            Text("Сфотографировать")
                        }
                        .font(.title3)
                        .foregroundStyle(Color.black)
                        .padding(10)
                        .background(Color.purple.opacity(0.5))
                        .cornerRadius(12)
                    }
                    .fullScreenCover(isPresented: self.$showCamera) {
                        AccessCameraView(selectedImageData: $viewModel.selectedImageData)
                    }
                }
                .padding(.top, 16)
                
                Spacer()
            }
            .navigationTitle("Редактирование фото")
            .navigationBarTitleDisplayMode(.inline)
        }
       
    }
}

#Preview {
    PhotoEditorView(viewModel: PhotoEditorViewModel())
}


//extension UIImage {
//    enum CompressionError: Error {
//        case failedToCompressToDataOfGivenSize
//    }
//
//    func jpegData(ofSizeLessThenOrEqualTo maxSize: CGFloat) throws -> Data? {
//        var shouldContinue: Bool = true
//        let maxSizeInBytes = maxSize * 1024 * 1024
//        var compressionQuality: CGFloat = 0.9
//        repeat {
//            guard let jpegData = self.jpegData(compressionQuality: compressionQuality) else {
//                return nil
//            }
//            if (CGFloat(jpegData.count) < maxSizeInBytes) {
//                return jpegData
//            }
//            compressionQuality -= 0.1
//            shouldContinue = compressionQuality > 0.1
//        } while shouldContinue
//        throw CompressionError.failedToCompressToDataOfGivenSize
//    }
//}

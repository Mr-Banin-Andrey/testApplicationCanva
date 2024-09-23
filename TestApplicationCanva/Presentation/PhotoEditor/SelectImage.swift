//
//  SelectImage.swift
//  TestApplicationCanva
//
//  Created by Андрей Банин on 23.9.24..
//

import SwiftUI


//struct SelectImage: View {
//    
//    var body: some View {
//        VStack {
//            PhotosPicker(
//                selection: $selectedItem,
//                matching: .images,
//                photoLibrary: .shared()
//            ) {
//                HStack {
//                    Image(systemName: "photo.on.rectangle")
//                    
//                    Text("Открыть галерею")
//                    
//                    Spacer()
//                }
//                .padding(.vertical, 4)
//                
//            }
//            .onChange(of: selectedItem) { _, newItem in
//                Task {
//                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
//                        viewModel.initialPositionImage()
//                        withAnimation {
////                                    viewModel.selectedImage = UIImage(data: data)
//                            viewModel.selectedImageData = data
//                            selectedItem = nil
//                        }
//                    }
//                }
//            }
//            
//            Divider()
//            
//            Button {
//                self.showCamera.toggle()
//                if viewModel.selectedImageData != nil {
//                    viewModel.initialPositionImage()
//                }
//            } label: {
//                HStack {
//                    Image(systemName: "camera")
//                    
//                    Text("Сфотографировать")
//                    
//                    Spacer()
//                }
//                .padding(.vertical, 4)
//            }
//            .fullScreenCover(isPresented: self.$showCamera) {
//                AccessCameraView(selectedImageData: $viewModel.selectedImageData)
//            }
//            Spacer()
//        }
//    }
//}

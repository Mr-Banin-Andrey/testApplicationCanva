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
    @State private var scale = 0.0
    
    @State private var showBottomSheet: Bool = false
    
    var body: some View {
        NavigationView {
            VStack{
                if viewModel.selectedImageData != nil {
                    if let uiImage = UIImage(data: viewModel.selectedImageData ?? Data()) {
                        VStack {
                            ZStack {
                                Image(uiImage: uiImage)
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
                                    .toolbar(content: {
                                        Button(action: {
                                            withAnimation {
                                                viewModel.imageRotation()
                                            }
                                        }, label: {
                                            Image(systemName: "rotate.right")
                                        })
                                        
                                        Button(action: {
                                            withAnimation {
                                                viewModel.cancel()
                                            }
                                        }, label: {
                                            Image(systemName: "xmark")
                                        })
                                    })
                            }
                            .rotationEffect(.degrees(viewModel.rotation))
                        }
                        .rotated()
                        .padding(.top, 24)
                    }
                } else {
                    Button(action: {
                        showBottomSheet.toggle()
                    }, label: {
                        Text("Выбрать картинку для редактирования")
                    })
                    .sheet(isPresented: $showBottomSheet) {
                        //TODO: переписать на единое вью
                        VStack {
                            PhotosPicker(
                                selection: $selectedItem,
                                matching: .images,
                                photoLibrary: .shared()
                            ) {
                                HStack {
                                    Image(systemName: "photo.on.rectangle")
                                    
                                    Text("Открыть галерею")
                                    
                                    Spacer()
                                }
                                .padding(.vertical, 4)
                                
                            }
                            .onChange(of: selectedItem) { _, newItem in
                                Task {
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        viewModel.initialPositionImage()
                                        withAnimation {
        //                                    viewModel.selectedImage = UIImage(data: data)
                                            viewModel.selectedImageData = data
                                            selectedItem = nil
                                        }
                                    }
                                }
                            }
                            
                            Divider()
                            
                            Button {
                                self.showCamera.toggle()
                                if viewModel.selectedImageData != nil {
                                    viewModel.initialPositionImage()
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "camera")
                                    
                                    Text("Сфотографировать")
                                    
                                    Spacer()
                                }
                                .padding(.vertical, 4)
                            }
                            .fullScreenCover(isPresented: self.$showCamera) {
                                AccessCameraView(selectedImageData: $viewModel.selectedImageData)
                            }
                            Spacer()
                        }
                        .padding(.vertical, 38)
                        .padding(.horizontal, 16)
                        .presentationDetents([.height(130)])
                        .presentationDragIndicator(.visible)
                    }
                }
            }
            .navigationTitle("Изменение фото")
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
//            VStack {

                
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

//                if viewModel.selectedImageData != nil {
//                    //TODO: открывается sheet и там редактируется изобоажение
//                    NavigationLink {
////                        EditingImageView(imageData: viewModel.selectedImageData ?? Data())
//                        TestFile(imageData: viewModel.selectedImageData ?? Data(), screenType: .case1)
//                    } label: {
//                        HStack {
//                            Image(systemName: "square.and.pencil")
//
//                            Text("Редактирование")
//                        }
//                        .foregroundStyle(Color.purple)
//                    }
////                } label: {
////
////                }
//                    .padding(8)
//                }


//                VStack {

//                    
//
//                }
//                .padding(.top, 16)
//                
//                Spacer()
//            }
            
            
//            .navigationBarTitleDisplayMode(.inline)
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

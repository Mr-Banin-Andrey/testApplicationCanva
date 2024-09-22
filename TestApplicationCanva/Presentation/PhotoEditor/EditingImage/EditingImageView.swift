//
//  .swift
//  TestApplicationCanva
//
//  Created by Андрей Банин on 22.9.24..
//

import SwiftUI
import PencilKit

struct EditingImageView: View {
    @Environment(\.undoManager) private var undoManager
    @State private var canvasView = PKCanvasView()
    @State private var tool = PKToolPicker()

    @State private var showPicker: Bool = true
    @State var imageData: Data = (UIImage(named: "images")?.jpegData(compressionQuality: 1) ?? Data())

    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                HStack {
                    Button("Clear") {
                        canvasView.drawing = PKDrawing()
                    }
                    Button("Undo") {
                        undoManager?.undo()
                    }
                    Button("Redo") {
                        undoManager?.redo()
                    }
                    Button("Picker") {
                        showPicker.toggle()
                    }
                }
                GeometryReader { proxy -> AnyView in
                    
                    let size = proxy.frame(in: .global).size
                    
                    return AnyView(
                        Canvas(
                            canvas: $canvasView,
                            toolPicker: $tool,
                            isPickerHidden: $showPicker,
                            imageData: $imageData,
                            rect: size
                        )
                    )
                }
//                Spacer()
            }
        }
    }
}

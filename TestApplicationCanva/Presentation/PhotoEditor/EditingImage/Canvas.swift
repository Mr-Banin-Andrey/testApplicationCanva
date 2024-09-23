//
//  Canvas.swift
//  TestApplicationCanva
//
//  Created by Андрей Банин on 22.9.24..
//

import SwiftUI
import PencilKit

struct Canvas: UIViewRepresentable  {
    @Binding var canvas: PKCanvasView
    @Binding var toolPicker: PKToolPicker

    @Binding var isPickerHidden: Bool
    @Binding var imageData: Data

    var rect: CGSize

    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.isOpaque = false
        canvas.backgroundColor = .clear

        if let image = UIImage(data: imageData) {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true

            let subView = canvas.subviews[0]
            subView.addSubview(imageView)
            subView.sendSubviewToBack(imageView)
        }

        return canvas
    }

    func updateUIView(_ canvasView: PKCanvasView, context: Context) {
        toolPicker.setVisible(isPickerHidden, forFirstResponder: self.canvas)
        toolPicker.addObserver(self.canvas)
        self.canvas.becomeFirstResponder()
    }
}

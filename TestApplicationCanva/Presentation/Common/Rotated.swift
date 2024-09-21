//
//  Rotated.swift
//  TestApplicationCanva
//
//  Created by Андрей Банин on 21.9.24..
//

import SwiftUI

struct Rotated<Rotated: View>: View {
    var view: Rotated
    var angle: Angle

    @State private var size: CGSize = .zero
    
    init(_ view: Rotated, angle: Angle = .degrees(0)) {
        self.view = view
        self.angle = angle
    }
    
    var body: some View {
        let newFrame = CGRect(origin: .zero, size: size)
            .offsetBy(dx: -size.width/2, dy: -size.height/2)
            .applying(.init(rotationAngle: CGFloat(angle.radians)))
            .integral

        return view
            .fixedSize()
            .captureSize(in: $size)
            .rotationEffect(angle)
            .frame(width: newFrame.width, height: newFrame.height)
    }
}

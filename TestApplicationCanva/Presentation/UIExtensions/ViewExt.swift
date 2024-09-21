//
//  ViewExt.swift
//  TestApplicationCanva
//
//  Created by Андрей Банин on 21.9.24..
//

import SwiftUI

extension View {
    func captureSize(in binding: Binding<CGSize>) -> some View {
        overlay(GeometryReader { proxy in
            Color.clear.preference(key: SizeKey.self, value: proxy.size)
        })
            .onPreferenceChange(SizeKey.self) { size in binding.wrappedValue = size }
    }
    
    func rotated(_ angle: Angle = .degrees(0)) -> some View {
        Rotated(self, angle: angle)
    }
}

private struct SizeKey: PreferenceKey {
    static let defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

//
//  ContentView.swift
//  TestApplicationCanva
//
//  Created by Андрей Банин on 20.9.24..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        PhotoEditorView(viewModel: PhotoEditorViewModel())
    }
}

#Preview {
    ContentView()
}

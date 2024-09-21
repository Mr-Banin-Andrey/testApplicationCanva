//
//  ContentView.swift
//  TestApplicationCanva
//
//  Created by Андрей Банин on 20.9.24..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PhotoEditorView(viewModel: PhotoEditorViewModel())
                .tabItem {
                    Label("Питание", systemImage: "fork.knife.circle")
                }
        }
        .tint(.black)
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  voicemark
//
//  Created by 付贵松 on 2023-04-07.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PhotoViewModel()
    private let columns = [GridItem(.adaptive(minimum: 100), spacing: 8)]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(viewModel.assets, id: \.self) { asset in
                        AssetThumbnail(asset: asset, viewModel: viewModel)
                            .frame(width: 100, height: 100)
                    }
                }
            }
            .padding()
            .navigationTitle("Hi, VoiceMark")
            .onAppear {
                viewModel.requestPhotoLibraryAccess()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

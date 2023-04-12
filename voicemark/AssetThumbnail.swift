import SwiftUI
import Photos

struct AssetThumbnail: View {
    var asset: PHAsset
    @ObservedObject var viewModel: PhotoViewModel
    
    @State private var thumbnail: UIImage? = nil
    
    var body: some View {
        NavigationLink(destination: PhotoDetailView(asset: asset, viewModel: viewModel)) {
            Image(uiImage: thumbnail ?? UIImage())
                .resizable()
                .scaledToFill()
        }
        .buttonStyle(PlainButtonStyle())
        .onAppear {
            viewModel.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill) { image in
                thumbnail = image
            }
        }
    }
}

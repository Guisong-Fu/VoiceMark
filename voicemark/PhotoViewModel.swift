import SwiftUI
import Photos

class PhotoViewModel: ObservableObject {
    @Published var assets: [PHAsset] = []
    private let imageManager = PHCachingImageManager()
    
    func requestPhotoLibraryAccess() {
        PHPhotoLibrary.requestAuthorization { (status) in
            DispatchQueue.main.async {
                switch status {
                case .authorized, .limited:
                    print("Photo Access granted or limited")
                    self.fetchAssets()
                case .denied, .restricted:
                    print("Access denied")
                    // Access to the photo library is denied or restricted, handle accordingly
                default:
                    print("Not determined")
                    // Access hasn't been determined yet, the user will be prompted when you request access
                }
            }
        }
    }

    private func fetchAssets() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        assets = fetchResult.objects(at: IndexSet(0..<fetchResult.count))
    }
    
    func requestImage(for asset: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, completion: @escaping (UIImage?) -> Void) {
        imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: nil) { (image, _) in
            completion(image)
        }
    }
}

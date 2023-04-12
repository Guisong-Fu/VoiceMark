import SwiftUI
import Photos
import AVFoundation

struct PhotoDetailView: View {
    var asset: PHAsset
    @ObservedObject var viewModel: PhotoViewModel
    @StateObject private var audioRecorder = AudioRecorder()

    @State private var selectedImage: UIImage? = nil

    var body: some View {

        VStack {

            if let image = selectedImage {
                Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, alignment: .top)
            } else {
                ProgressView()
                        .frame(maxWidth: .infinity, alignment: .top)
            }

            // this also works.
//            Button(action: {
//                print("Recoding button being pressed")
//            }, label: {
//                Image(systemName: "mic.fill")
//                        .resizable()
//                        .frame(width: 40, height: 40)
//                        .padding()
//                        .background(audioRecorder.isRecording ? Color.red : Color.blue)
//                        .clipShape(Circle())
//
//                        .onTapGesture {
//                            print("Tapped")
//
//                            if audioRecorder.isRecording {
//                                audioRecorder.stopRecording()
//                            } else {
//                                // Request microphone permission
//                                AVAudioSession.sharedInstance().requestRecordPermission { allowed in
//                                    if allowed {
//                                        audioRecorder.startRecording()
//                                    } else {
//                                        print("Microphone access denied")
//                                    }
//                                }
//                            }
//                        }
//            })
//                    .padding(.top)


            Image(systemName: "mic.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding()
                    .background(audioRecorder.isRecording ? Color.red : Color.blue)
                    .clipShape(Circle())
                    .padding(.top)
                    .onTapGesture {
                        print("Tapped")

                        if audioRecorder.isRecording {
                            audioRecorder.stopRecording()
                        } else {
                            // Request microphone permission
                            AVAudioSession.sharedInstance().requestRecordPermission { allowed in
                                if allowed {
                                    audioRecorder.startRecording()
                                } else {
                                    print("Microphone access denied")
                                }
                            }
                        }
                    }



            Spacer()


        }
                .onAppear {
                    viewModel.requestImage(for: asset, targetSize: UIScreen.main.bounds.size, contentMode: .aspectFill) { image in
                        selectedImage = image
                    }
                }
                .navigationBarTitle("Photo Detail", displayMode: .inline)
    }
}

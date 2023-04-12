import SwiftUI

struct VoiceMessageIcon: View {
    @ObservedObject var audioRecorder: AudioRecorder

    var body: some View {
        Button(action: {
            if audioRecorder.isPlaying {
                audioRecorder.stopPlaying()
            } else {
                audioRecorder.startPlaying()
            }
        }) {
            Image(systemName: "message.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(audioRecorder.hasRecording ? .blue : .gray)
        }
        .disabled(!audioRecorder.hasRecording)
    }
}

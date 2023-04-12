import AVFoundation
import Combine


class AudioRecorder: NSObject, ObservableObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    @Published var isRecording = false
    @Published var isPlaying = false
    @Published var hasRecording = false

    private var audioRecorder: AVAudioRecorder!
    private var audioPlayer: AVAudioPlayer!

    private(set) var audioFileURL: URL?


    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()

        print("Recording Starts")

        do {
            try audioSession.setCategory(.record, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }

        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("record.m4a")
        audioFileURL = url

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {

            DispatchQueue.main.async {
                self.isRecording = true
            }

            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            isRecording = true
        } catch {
            print("Failed to start audio recording: \(error)")
        }


    }


    func stopRecording() {

        DispatchQueue.main.async {
            self.isRecording = false
            self.hasRecording = true
        }

        print("Recording Ends")

        audioRecorder.stop()
        isRecording = false
        hasRecording = true
    }

    func startPlaying() {
        guard let url = audioFileURL else {
            return
        }

        print("Record playing")

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.delegate = self
            audioPlayer.play()
            isPlaying = true
        } catch {
            print("Failed to start audio playback: \(error)")
        }
    }

    func stopPlaying() {

        print("Record playing")

        audioPlayer.stop()
        isPlaying = false
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
    }
}

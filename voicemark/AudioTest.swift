//import AVFoundation
//import Combine
//import SwiftUI
//
//class AudioTest: NSObject, ObservableObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
//
//    var recordButton: UIButton!
//    var recordingSession: AVAudioSession!
//    var audioRecorder: AVAudioRecorder!
//
//    @Published var isRecording = false
//    @Published var isPlaying = false
//    @Published var hasRecording = false
//
////    private var audioRecorder: AVAudioRecorder!
//    private var audioPlayer: AVAudioPlayer!
//
//    private(set) var audioFileURL: URL?
//
//
//    private func recordAudio(audioSession: AVAudioSession) {
//        print("Recording Starts")
//
//        do {
//            try audioSession.setCategory(.record, mode: .default)
//            try audioSession.setActive(true)
//        } catch {
//            print("Failed to set up audio session: \(error)")
//        }
//
//        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("record.m4a")
//        audioFileURL = url
//
//        let settings = [
//            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//            AVSampleRateKey: 12000,
//            AVNumberOfChannelsKey: 1,
//            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//        ]
//
//        do {
//
//            DispatchQueue.main.async {
//                self.isRecording = true
//            }
//
//            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
//            audioRecorder.delegate = self
//            audioRecorder.record()
//            isRecording = true
//        } catch {
//            print("Failed to start audio recording: \(error)")
//        }
//
//    }
//
//    func loadRecordingUI() {
//        recordButton = UIButton(frame: CGRect(x: 64, y: 64, width: 128, height: 64))
//        recordButton.setTitle("Tap to Record", for: .normal)
//        recordButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
//        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
//        view.addSubview(recordButton)
//    }
//
//
//    private func recordAudio2(audioSession: AVAudioSession) {
//        do {
//            try recordingSession.setCategory(.playAndRecord, mode: .default)
//            try recordingSession.setActive(true)
//            recordingSession.requestRecordPermission() { [unowned self] allowed in
//                DispatchQueue.main.async {
//                    if allowed {
//                        self.loadRecordingUI()
//                    } else {
//                        // failed to record!
//                    }
//                }
//            }
//        } catch {
//            // failed to record!
//        }
//    }
//
//    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
//
//
//    func finishRecording(success: Bool) {
//        audioRecorder.stop()
//        audioRecorder = nil
//
//        if success {
//            recordButton.setTitle("Tap to Re-record", for: .normal)
//        } else {
//            recordButton.setTitle("Tap to Record", for: .normal)
//            // recording failed :(
//        }
//    }
//
//
//    func startRecording2() {
//        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
//
//        let settings = [
//            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//            AVSampleRateKey: 12000,
//            AVNumberOfChannelsKey: 1,
//            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//        ]
//
//        do {
//            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
//            audioRecorder.delegate = self
//            audioRecorder.record()
//
//            recordButton.setTitle("Tap to Stop", for: .normal)
//        } catch {
//            finishRecording(success: false)
//        }
//    }
//
//
//
//    func startRecording() {
//
//        let audioSession = AVAudioSession.sharedInstance()
//        recordAudio(audioSession: audioSession)
//
////        audioSession.requestRecordPermission { [weak self] allowed in
////            guard let self = self else { return }
////            if allowed {
////                DispatchQueue.main.async {
////                    self.recordAudio(audioSession: audioSession)
////                }
////            } else {
////                print("Microphone access denied")
////            }
////        }
//    }
//
//
//    func stopRecording() {
//
//        DispatchQueue.main.async {
//            self.isRecording = false
//            self.hasRecording = true
//        }
//
//        print("Recording Ends")
//
//        audioRecorder.stop()
//        isRecording = false
//        hasRecording = true
//    }
//
//    func startPlaying() {
//        guard let url = audioFileURL else { return }
//
//        print("Record playing")
//
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer.delegate = self
//            audioPlayer.play()
//            isPlaying = true
//        } catch {
//            print("Failed to start audio playback: \(error)")
//        }
//    }
//
//    func stopPlaying() {
//
//        print("Record playing")
//
//        audioPlayer.stop()
//        isPlaying = false
//    }
//
//    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//        isPlaying = false
//    }
//}

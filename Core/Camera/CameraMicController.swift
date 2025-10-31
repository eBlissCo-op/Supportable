import AVFoundation
import Combine

final class CameraMicController: NSObject, ObservableObject {
    let session = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "supportable.session.queue")
    
    @Published @MainActor var isRunning: Bool = false
    
    private var videoDeviceInput: AVCaptureDeviceInput?
    private var audioDeviceInput: AVCaptureDeviceInput?
    
    override init() {
        super.init()
        session.sessionPreset = .high
    }
    
    func start() {
        sessionQueue.async {
            do {
                try self.configureSession()
                self.session.startRunning()
                DispatchQueue.main.async { self.isRunning = true }
            } catch {
                print("Camera/Mic start error: \(error)")
            }
        }
    }
    
    func stop() {
        sessionQueue.async {
            self.session.stopRunning()
            self.teardownInputs()
            DispatchQueue.main.async { self.isRunning = false }
        }
    }
    
    private func configureSession() throws {
        session.beginConfiguration()
        defer { session.commitConfiguration() }
        
        // Clear existing
        for input in session.inputs {
            session.removeInput(input)
        }
        for output in session.outputs {
            session.removeOutput(output)
        }
        
        // Video
        guard let video = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            throw NSError(domain: "Supportable", code: -1, userInfo: [NSLocalizedDescriptionKey: "No camera available"])
        }
        videoDeviceInput = try AVCaptureDeviceInput(device: video)
        if session.canAddInput(videoDeviceInput!) {
            session.addInput(videoDeviceInput!)
        }
        
        let videoOutput = AVCaptureVideoDataOutput()
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
        }
        
        // Audio
        guard let mic = AVCaptureDevice.default(for: .audio) else {
            throw NSError(domain: "Supportable", code: -2, userInfo: [NSLocalizedDescriptionKey: "No microphone available"])
        }
        audioDeviceInput = try AVCaptureDeviceInput(device: mic)
        if session.canAddInput(audioDeviceInput!) {
            session.addInput(audioDeviceInput!)
        }
        
        let audioOutput = AVCaptureAudioDataOutput()
        if session.canAddOutput(audioOutput) {
            session.addOutput(audioOutput)
        }
    }
    
    private func teardownInputs() {
        if let input = videoDeviceInput {
            session.removeInput(input)
        }
        if let input = audioDeviceInput {
            session.removeInput(input)
        }
        videoDeviceInput = nil
        audioDeviceInput = nil
    }
}

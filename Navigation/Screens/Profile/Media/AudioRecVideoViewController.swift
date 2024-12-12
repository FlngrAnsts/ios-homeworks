//
//  AudioRecVideoViewController.swift
//  Navigation
//
//  Created by Anastasiya on 04.07.2024.
//

import UIKit
import AVFoundation
import AVFAudio

class AudioRecVideoViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var recordSession: AVAudioSession!
    var isRecord: Bool = false
    var recordingName: URL!
    
    private lazy var recordButton: CustomButton = {
        let button = CustomButton(title: "", titleColor: .color){
            if(self.audioRecorder != nil){
                self.finishAudioRecording(success: true)
            }else{
                self.startRecord()
            }
            
        }
        button.setImage(UIImage(systemName: "record.circle"), for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private lazy var playButton: CustomButton = {
        let button = CustomButton(title: "", titleColor: .color){
            self.play()
        }
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
        chekPermission()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.tintColor = .systemBlue
        navigationBar?.barStyle = .default
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Audio Record".localized
    }
    
    private func addSubviews(){
        recordingName = getDirectoryUrl().appendingPathComponent("output.m4a")
        view.addSubview(recordButton)
        view.addSubview(playButton)
    }
    
    private func setupConstraints(){
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            recordButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: -70),
            recordButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 70),
            recordButton.widthAnchor.constraint(equalToConstant: 50),
            recordButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            playButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: -70),
            playButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -70),
            playButton.widthAnchor.constraint(equalToConstant: 50),
            playButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    //разрешение на использование микрофона
    private func chekPermission(){
        let status = AVCaptureDevice.authorizationStatus(for: .audio)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .audio) { success in
                print(success)
            }
        case.restricted:
            print()
        case .denied:
            print()
        case.authorized:
            print()
        }
    }
    
    private func getDirectoryUrl() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func startRecord(){
        if audioRecorder == nil {
            setupRecorder()
            recordButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            audioRecorder.record()
        }
    }
    
    private func setupRecorder() {
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            audioRecorder = try AVAudioRecorder(url: recordingName, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
            
        } catch {
            finishAudioRecording(success: false)
            print(#line, #function, error.localizedDescription)
        }
    }
    
    private func finishAudioRecording(success: Bool) {
        
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            print("Done")
        } else {
            print("Error")
        }
        recordButton.setImage(UIImage(systemName: "record.circle"), for: .normal)
    }
    
    private func play(){
        do {
            if(self.audioPlayer == nil){
                audioPlayer = try AVAudioPlayer(contentsOf: recordingName)
                audioPlayer.prepareToPlay()
                audioPlayer.volume = 5
                audioPlayer.play()
                audioPlayer.delegate = self
                playButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            }
        } catch {
            self.audioPlayer = nil
        }
    }
    
    func stpoPlay(){
        self.audioPlayer.stop()
        self.audioPlayer = nil
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
}

extension AudioRecVideoViewController: AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("audioPlayerDidFinishPlaying")
        self.stpoPlay()
    }
}

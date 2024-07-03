//
//  AudioViewController.swift
//  Navigation
//
//  Created by Anastasiya on 02.07.2024.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController {
    
    private var audioPlayer = AVAudioPlayer()
    
    var trackNumber = 0
    
    private let audioList = ["01 UGLY","02 Inside Beast","07 Last Heaven","11 Filth in the Beauty","05 Suicide Circus","03 Ninth Odd Smell","Enemy","League_of_Legends_Cailin_Russo_Chrissy_Costanza_-_Phoenix_(musmore.com)"]
    
    private enum Constants{
        static let buttonWidth = (UIScreen.main.bounds.width - (16+10+10+16))/3
    }
    
    private lazy var songName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemGray6
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        return label
    }()
    
    private lazy var playBttn: CustomButton = {
        let button = CustomButton(title: "", titleColor: .color) {
            self.play()
        }
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 10
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stopBttn: CustomButton = {
        let button = CustomButton(title: "", titleColor: .color) {
            self.stop()
        }
        button.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 10
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nextTrackBttn: CustomButton = {
        let button = CustomButton(title: "", titleColor: .color) {
            self.nextTrack()
        }
        button.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 10
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var backTrackBttn: CustomButton = {
        let button = CustomButton(title: "", titleColor: .color) {
            self.backTrack()
        }
        button.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 10
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupContraints()
        setupAudoiPlayer()
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
        stop()
        
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Music"
        
    }
    
    private func addSubviews(){
        view.addSubview(songName)
        view.addSubview(playBttn)
        view.addSubview(stopBttn)
        view.addSubview(nextTrackBttn)
        view.addSubview(backTrackBttn)
    }
    
    private func setupContraints(){
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            songName.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 70),
            songName.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 30),
            songName.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -30),
            songName.heightAnchor.constraint(equalToConstant: 50),
            
            playBttn.topAnchor.constraint(equalTo: songName.bottomAnchor, constant: 350),
            playBttn.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            playBttn.heightAnchor.constraint(equalToConstant: 50),
            playBttn.widthAnchor.constraint(equalToConstant: 50),
            
            stopBttn.topAnchor.constraint(equalTo: playBttn.bottomAnchor, constant: 16),
            stopBttn.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            stopBttn.heightAnchor.constraint(equalToConstant: 50),
            stopBttn.widthAnchor.constraint(equalToConstant: 50),
            
            nextTrackBttn.topAnchor.constraint(equalTo: songName.bottomAnchor, constant: 350+(50+16)/2),
            nextTrackBttn.leadingAnchor.constraint(equalTo: playBttn.trailingAnchor, constant: 32),
            nextTrackBttn.heightAnchor.constraint(equalToConstant: 50),
            nextTrackBttn.widthAnchor.constraint(equalToConstant: 50),
            
            backTrackBttn.topAnchor.constraint(equalTo: songName.bottomAnchor, constant: 350+(50+16)/2),
            backTrackBttn.trailingAnchor.constraint(equalTo: playBttn.leadingAnchor, constant: -32),
            backTrackBttn.heightAnchor.constraint(equalToConstant: 50),
            backTrackBttn.widthAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    private func setupAudoiPlayer(){
        do{
            let track = audioList[trackNumber]
            songName.text = track
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: track, ofType: "mp3")!))
            
            setupAugioSession()
        }
        catch {
            print(error)
        }
        
    }
    
    private func setupAugioSession(){
        let audioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setCategory(.playback)
        }catch{
            print("ERROR")
        }
    }
    
    func play(){
        if audioPlayer.isPlaying{
            audioPlayer.stop()
            playBttn.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }else{
            audioPlayer.play()
            playBttn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    func stop(){
        audioPlayer.stop()
        playBttn.setImage(UIImage(systemName: "play.fill"), for: .normal)
        setupAudoiPlayer()
    }
    
    func nextTrack(){
        if trackNumber == (audioList.count - 1){
            trackNumber = 0
        }else {
            trackNumber += 1
        }
        setupAudoiPlayer()
        play()
    }
    
    func backTrack(){
        if trackNumber == 0{
            trackNumber = audioList.count - 1
        }else {
            trackNumber -= 1
        }
        setupAudoiPlayer()
        play()
    }
    
}

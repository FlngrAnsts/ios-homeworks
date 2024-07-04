//
//  MediaTableViewCell.swift
//  Navigation
//
//  Created by Anastasiya on 02.07.2024.
//

import UIKit

class MediaTableViewCell: UITableViewCell {
    
    static let cellID = "MediaTableViewCell"
    
    var buttonTapAudioCallback: () -> () = {}
    var buttonTapVideoCallback: () -> () = {}
    var buttonTapRECCallback: () -> () = {}
    
    private enum Constants{
        static let buttonWidth = (UIScreen.main.bounds.width - (16+10+10+16))/3
    }
    
    private lazy var audioBttn: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setImage(UIImage(systemName: "music.note.list"), for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tapAudioButton(_:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    @objc func tapAudioButton(_: UIResponder){
        buttonTapAudioCallback()
    }
    
    private lazy var videoBttn: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setImage(UIImage(systemName: "video"), for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 10
        
        button.addTarget(self, action: #selector(tapVideoButton(_:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    @objc func tapVideoButton(_: UIResponder){
        buttonTapVideoCallback()
    }
   
    
    private lazy var audioRecBttn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "music.mic.circle"), for: .normal)
        button.addTarget(self, action: #selector(tapAudioRecButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    @objc func tapAudioRecButton(_: UIResponder){
        buttonTapRECCallback()
    }

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(
        style: style,
        reuseIdentifier: reuseIdentifier)
        
        tuneView()
        addSubviews()
        setupConstraints()
//        audioButton()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tuneView(){
        contentView.backgroundColor = .white
        accessoryType = .none
    }
    
    private func addSubviews(){
        contentView.addSubview(audioBttn)
        contentView.addSubview(videoBttn)
        contentView.addSubview(audioRecBttn)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            audioBttn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            audioBttn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            audioBttn.heightAnchor.constraint(equalToConstant: 50),
            audioBttn.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            audioBttn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            videoBttn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            videoBttn.leadingAnchor.constraint(equalTo: audioBttn.trailingAnchor, constant: 10),
            videoBttn.heightAnchor.constraint(equalToConstant: 50),
            videoBttn.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            videoBttn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            audioRecBttn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            audioRecBttn.leadingAnchor.constraint(equalTo: videoBttn.trailingAnchor, constant: 10),
            audioRecBttn.heightAnchor.constraint(equalToConstant: 50),
            audioRecBttn.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            audioRecBttn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            audioRecBttn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
        
        
    }



}

//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Anastasiya on 01.04.2024.
//

import UIKit



class ProfileHeaderView: UIView {
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "Avatar")
        
        
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        
        imageView.layer.cornerRadius = 65.0
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Anastasiya"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let text = UILabel()
        
        text.text = "Тут я что-то написал..."
        text.font = UIFont.systemFont(ofSize: 14)
        text.textColor = .gray
        
        text.translatesAutoresizingMaskIntoConstraints = false
        
        return text
    }()
    
    lazy var setStatusButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.backgroundColor = .systemBlue
        
        button.layer.cornerRadius = 4
        
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    @objc func buttonPressed(_ sender: UIButton) {
        print(statusLabel.text!)
    }
    
    func addSubviews() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(setStatusButton)
    }
    
    func setupContraints() {
        let safeAreaGuide = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            avatarImageView.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 125),
            avatarImageView.widthAnchor.constraint(equalToConstant: 125),
            
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            
            statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -34),
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20)
            
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

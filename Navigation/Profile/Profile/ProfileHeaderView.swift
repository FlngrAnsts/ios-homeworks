//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Anastasiya on 01.04.2024.
//

import UIKit

class ProfileHeaderView: UIView {
    
   
    
    override var intrinsicContentSize: CGSize {
        CGSize(
            width: UIView.noIntrinsicMetric,
            height: 230
        )
    }
    
    private enum Constant {
        static let avatarSize: CGFloat = 125
        static let closeAnimateButtonSize: CGFloat = 40
    }
    
    lazy  var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .customBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        
        return view
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "Avatar")
        
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        
        imageView.layer.cornerRadius = 65.0
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(
                   target: self,
                   action: #selector(tapAvatar)
               )
        imageView.addGestureRecognizer(tap)
        
        return imageView
    }()
    
    lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Anastasiya"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .customTextColor
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let text = UILabel()
        
        text.text = "Тут я что-то написал..."
        text.font = UIFont.systemFont(ofSize: 14)
        text.textColor = .customTextColor
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 2
        
        text.translatesAutoresizingMaskIntoConstraints = false
        
        return text
    }()
    
    lazy var setStatusButton: CustomButton = {
        let button = CustomButton(title: "Show status", titleColor: .white){
            self.buttonPressed()
        }
        
        button.backgroundColor = .systemBlue
        
        button.layer.cornerRadius = 4
        
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    lazy var closeAnimateButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.alpha = 0
        
        button.addTarget(self, action: #selector(closeAnimateButtonPressed(_:)), for: .touchUpInside)
        button.tintColor = .customTextColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    func buttonPressed() {
        print(statusLabel.text!)
      
    }
    
    @objc func closeAnimateButtonPressed(_ sender: UIButton) {
        closeAnimationExample()
     
    }
    
    @objc private func tapAvatar(gesture: UIGestureRecognizer) {
        if gesture.state == .ended {
            openAnimationExample()
            
            print("Did tap ")
        }
    }
    
    
    private func openAnimationExample() {
        let centerX = UIScreen.main.bounds.width/2
        let centerY = (UIScreen.main.bounds.height)*0.45
        
        let newSize = UIScreen.main.bounds.width/Constant.avatarSize
        
        UIView.animateKeyframes(
            withDuration: 0.8,
            delay: 1.0,
            options: .calculationModeCubic,
            animations: {
                // 1
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 0.5
                ) {
                    self.avatarImageView.center = CGPoint(
                        x: centerX,
                        y: centerY
                    )
                    self.avatarImageView.transform = CGAffineTransform(
                        scaleX: newSize,
                        y: newSize
                    )
                    self.avatarImageView.layer.cornerRadius = 0
                    self.avatarImageView.layer.borderWidth = 0
                    
                    self.backgroundView.alpha = 0.6
                }
                
                // 2
                UIView.addKeyframe(
                    withRelativeStartTime: 0.5,
                    relativeDuration: 0.3
                ) {
                    self.closeAnimateButton.alpha = 1
                }
            },
            
            
            completion: { finished in
                print("Did finish Open animate")
            })
        
    }
    
    private func closeAnimationExample() {
        
        let center = 16 + Constant.avatarSize/2
        
        UIView.animate(
            withDuration: 0.5,
            delay: 1.0,
            options: .curveLinear
        ) {
            
            self.closeAnimateButton.alpha = 0.0
            
            self.backgroundView.alpha = 0.0
            
            self.avatarImageView.center = CGPoint(
                x: center,
                y: center
            )
            
            self.avatarImageView.layer.cornerRadius = 65
            self.avatarImageView.layer.borderWidth = 3
            self.avatarImageView.transform = CGAffineTransform.identity
            
            
        } completion: { finished in
            print("Did finish close animate")
        }
    }
    
    func setupProfile(user: User){
            avatarImageView.image = user.avatar
            fullNameLabel.text = user.fullName
            statusLabel.text = user.status
        }
    
    
    func addSubviews() {
        
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(setStatusButton)
        addSubview(backgroundView)
        addSubview(closeAnimateButton)
        addSubview(avatarImageView)
        
    }
    
    
    func setupContraints() {
        let safeAreaGuide = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constant.avatarSize),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constant.avatarSize),
            
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            fullNameLabel.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            
            statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -34),
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            
            backgroundView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            backgroundView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            backgroundView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            
            closeAnimateButton.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 16),
            closeAnimateButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            closeAnimateButton.widthAnchor.constraint(equalToConstant: Constant.closeAnimateButtonSize),
            closeAnimateButton.heightAnchor.constraint(equalToConstant: Constant.closeAnimateButtonSize),
            
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupContraints()
       // setUserInfo()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

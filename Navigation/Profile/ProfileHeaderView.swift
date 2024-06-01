//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Anastasiya on 01.04.2024.
//

import UIKit
import SnapKit


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
        view.backgroundColor = .white
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
        
        let longPressRoot = UILongPressGestureRecognizer(
            target: self,
            action: #selector(didLongPressRoot(gesture:))
        )
        longPressRoot.minimumPressDuration = 0.5
        addGestureRecognizer(longPressRoot)
        
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
    
    lazy var closeAnimateButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.alpha = 0
        
        button.addTarget(self, action: #selector(closeAnimateButtonPressed(_:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    @objc func buttonPressed(_ sender: UIButton) {
        print(statusLabel.text!)
    }
    
    @objc func closeAnimateButtonPressed(_ sender: UIButton) {
        closeAnimationExample()
    }
    
    @objc private func didLongPressRoot(gesture: UIGestureRecognizer) {
        if gesture.state == .ended {
            openAnimationExample()
            print("Did long press ")
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
                    self.backgroundView.transform = CGAffineTransform(
                        scaleX: 1,
                        y: 6
                    )
                    
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
    
    
    
    func addSubviews() {
        
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(setStatusButton)
        addSubview(backgroundView)
        addSubview(closeAnimateButton)
        addSubview(avatarImageView)
        
    }
    
    
    func setupContraints() {
        
        avatarImageView.snp.makeConstraints{ (make) -> Void in
            make.width.height.equalTo(Constant.avatarSize)
            make.top.leading.equalToSuperview().offset(16)
        }
        
        fullNameLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().inset(27)
            make.trailing.equalToSuperview().inset(-16)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(20)
        }
        
        setStatusButton.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(avatarImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        statusLabel.snp.makeConstraints{ (make) -> Void in
            make.bottom.equalTo(setStatusButton.snp.top).offset(-34)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(20)
        }
        
        backgroundView.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
//            make.height.equalTo(UIScreen.main.bounds.height)
        }
        closeAnimateButton.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(Constant.closeAnimateButtonSize)
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupContraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

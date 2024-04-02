//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Anastasiya on 01.04.2024.
//

import UIKit



class ProfileHeaderView: UIView {
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    lazy var avatar: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 16, y: 16, width: 125, height: 125))
        imageView.image = UIImage(named: "Avatar")
        
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        
        imageView.layer.cornerRadius = 65.0
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel()
        
        label.frame = CGRect(x: 16+125+20, y: 27, width: self.screenSize.width - (16+125+20+16), height: 20)
        label.text = "Anastasiya"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        
        return label
    }()
    
    lazy var status: UITextView = {
        let text = UITextView()
        text.frame = CGRect(x: 16+125+20, y: 16+125+16-34-28, width: self.screenSize.width - (16+125+20+16), height: 28
        )
        text.text = "Тут я что-то написал..."
        text.backgroundColor = .none
        text.font = UIFont.systemFont(ofSize: 14)
        text.textColor = .gray
        
        return text
    }()
    
    lazy var showButton: UIButton = {
        let button = UIButton()
        
        button.frame = CGRect(x: 16, y: 16+125+16, width: screenSize.width - 32, height: 50)
        
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.backgroundColor = .systemBlue
        
        button.layer.cornerRadius = 4
        
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        return button
    }()
    
    @objc func buttonPressed(_ sender: UIButton) {
        print(status.text!)
    }
    
    
    func addSubviews() {
        addSubview(avatar)
        addSubview(userName)
        addSubview(status)
        addSubview(showButton)
    }
    
    
}

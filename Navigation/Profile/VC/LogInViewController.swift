//
//  LogInViewController.swift
//  Navigation
//
//  Created by Anastasiya on 04.04.2024.
//

import UIKit

class LogInViewController: UIViewController {
    

    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false

        return contentView
    }()
    
    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var loginView: UITextField = {[unowned self] in
        let textView = UITextField()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.backgroundColor = .systemGray6
        
        textView.placeholder = "Email of phone"
        
        textView.borderStyle = UITextField.BorderStyle.roundedRect
        textView.autocorrectionType = UITextAutocorrectionType.no
        textView.keyboardType = UIKeyboardType.default
        textView.returnKeyType = UIReturnKeyType.done
        textView.clearButtonMode = UITextField.ViewMode.whileEditing
        
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 10
        textView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        textView.clipsToBounds = true
        
        textView.textColor = .black
        textView.font = UIFont.boldSystemFont(ofSize: 16)
        
        textView.autocapitalizationType = .none
        
        textView.delegate = self
        return textView
    }()
    
    private lazy var passwordView: UITextField = {[unowned self] in
        let textView = UITextField()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.backgroundColor = .systemGray6
        
        textView.placeholder = "Password"
        
        textView.borderStyle = UITextField.BorderStyle.roundedRect
        textView.autocorrectionType = UITextAutocorrectionType.no
        textView.keyboardType = UIKeyboardType.default
        textView.returnKeyType = UIReturnKeyType.done
        textView.clearButtonMode = UITextField.ViewMode.whileEditing
        textView.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 10
        textView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        textView.clipsToBounds = true
        
        textView.textColor = .black
        textView.font = UIFont.boldSystemFont(ofSize: 16)
        
        textView.autocapitalizationType = .none
        
        textView.isSecureTextEntry = true
        
        textView.delegate = self
        return textView
    }()
    
    lazy var logInButton: UIButton = {
        
        let button = UIButton(type: .roundedRect)
        
        button.layer.cornerRadius = 10
        
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.setBackgroundImage(UIImage(named: "ButtonColor"), for: .normal)
        
        button.clipsToBounds = true
        
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var error: UILabel = {
        let label = UILabel()
        label.text = "Неверный логин"
        label.textColor = .red
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.isHidden = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupContraints()
        
    }
    
    func setupView(){
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.backgroundColor = .white
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
        
        contentView.addSubview(logoView)
        contentView.addSubview(loginView)
        contentView.addSubview(passwordView)
        contentView.addSubview(logInButton)
        contentView.addSubview(error)
        
        scrollView.addSubview(contentView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        scrollView.contentInset.bottom = keyboardHeight ?? 0.0
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        let profileVC = ProfileViewController()
        let userProfile: UserService
        
#if DEBUG
        userProfile = TestUserService()
#else
        userProfile = CurrentUserService()
#endif
        
        
        
        if let user = userProfile.authorizationkUser(login: loginView.text!){
            profileVC.user = user
            self.navigationController?.pushViewController(profileVC, animated: true)
        } else {
            error.isHidden = false
        }
    }
    
    private func setupContraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoView.heightAnchor.constraint(equalToConstant: 100),
            logoView.widthAnchor.constraint(equalToConstant: 100),
            
            loginView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 120),
            loginView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginView.heightAnchor.constraint(equalToConstant: 50),
            
            passwordView.topAnchor.constraint(equalTo: loginView.bottomAnchor),
            passwordView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            passwordView.heightAnchor.constraint(equalToConstant: 50),
            
            logInButton.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            error.topAnchor.constraint(equalTo: logoView.bottomAnchor,constant: 60),
            error.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            error.trailingAnchor.constraint( equalTo: contentView.trailingAnchor,constant: -16),
            error.heightAnchor.constraint(equalToConstant: 20 ),
            
        ])
    }
    
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}



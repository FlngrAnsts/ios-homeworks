//
//  LogInViewController.swift
//  Navigation
//
//  Created by Anastasiya on 04.04.2024.
//

import UIKit

class LogInViewController: UIViewController {
    
    var viewModel: LogInModelProtocol?
    var coordinator: ProfileCoordinator?
    
    //    var logInResult = LogInError.self
    
    var loginDelegate: LoginViewControllerDelegate
    
    init(viewModel: LoginViewModel, delegate: LoginViewControllerDelegate) {
        self.viewModel = viewModel
        self.loginDelegate = delegate
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        textView.text = "Grivus"
        
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
        
        textView.text = "a123"
        
        textView.isSecureTextEntry = true
        
        textView.delegate = self
        return textView
    }()
    
    lazy var logInButton: CustomButton = {
        
        let button = CustomButton(title: "Log In", titleColor: .white){
            self.buttonPressed()
        }
        
        button.layer.cornerRadius = 10
        
        button.setBackgroundImage(UIImage(named: "ButtonColor"), for: .normal)
        
        button.clipsToBounds = true
        
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
    
    lazy var generatePassBtn: CustomButton = {
        
        let button = CustomButton(title: "Generate Password", titleColor: .white){
            self.generatePass()
        }
        
        button.layer.cornerRadius = 10
        
        button.setBackgroundImage(UIImage(named: "ButtonColor"), for: .normal)
        
        button.clipsToBounds = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        
        let indicator = UIActivityIndicatorView(style: .medium)
        
        indicator.isHidden = true
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
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
        contentView.addSubview(generatePassBtn)
        contentView.addSubview(activityIndicator)
        
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
    
    func logInError (caseOf error: LogInError){
        var errorMassage = ""
        
        switch error {
        case .userNotFound:
            errorMassage = "Такой пользователь не существует"
        case .incorrectPassord:
            errorMassage = "Неверный пароль"
        }
        
        
        let alert = UIAlertController(title: "Ошибка", message: errorMassage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        
        alert.modalTransitionStyle = .flipHorizontal
        alert.modalPresentationStyle = .pageSheet
        
        present(alert, animated: true)
    }
    
    func buttonPressed() {
        
        let service = PostService()
        let viewModel = ProfileViewModel(service: service)
        let profileVC = ProfileViewController(viewModel: viewModel)
        
        var userProfile: UserService
#if DEBUG
        userProfile = TestUserService(user: users[0])
#else
        userProfile = CurrentUserService(user: users[1])
#endif
        
        
        if (loginView.text?.isEmpty != nil && passwordView.text?.isEmpty != nil){
            do{
                try loginDelegate.check(login: loginView.text!, password: passwordView.text!){ result in
                    switch result{
                    case .success(_):
                        
//                        let profileVC = ProfileViewController(viewModel: viewModel)
                        profileVC.user = userProfile.user
                        self.navigationController?.pushViewController(profileVC, animated: true)
                    case .failure(let error):
                        self.logInError(caseOf: error)
                    }
                }
            }
            catch LogInError.userNotFound{
                logInError(caseOf: .userNotFound)
            }
            catch LogInError.incorrectPassord{
                logInError(caseOf: .incorrectPassord)
            }
            catch {
                print("some error")
            }
            
        }else{
            let alert = UIAlertController(title: "Ошибка", message: "Введите логин и пароль", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
            
            alert.modalTransitionStyle = .flipHorizontal
            alert.modalPresentationStyle = .pageSheet
            
            present(alert, animated: true)
        }
        
    }
    
    func generatePass(){
           
        let generate = BruteForce()
        
        var password = ""
        
        var userProfile: UserService
#if DEBUG
        userProfile = TestUserService(user: users[0])
#else
        userProfile = CurrentUserService(user: users[1])
#endif
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
//        очередь для подбора пороля
        let queue = DispatchQueue(label: "bruteForce", qos: .default)
        queue.async {
            
            password = generate.bruteForce(passwordToUnlock: userProfile.user.password)
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.passwordView.isSecureTextEntry = false
                self.passwordView.text = password
            }
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
//            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            error.topAnchor.constraint(equalTo: logoView.bottomAnchor,constant: 60),
            error.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            error.trailingAnchor.constraint( equalTo: contentView.trailingAnchor,constant: -16),
            error.heightAnchor.constraint(equalToConstant: 20 ),
            
            generatePassBtn.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 32),
            generatePassBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            generatePassBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            generatePassBtn.heightAnchor.constraint(equalToConstant: 50),
            generatePassBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: passwordView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: passwordView.centerYAnchor),
            
            
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



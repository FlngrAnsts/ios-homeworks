//
//  LogInViewController.swift
//  Navigation
//
//  Created by Anastasiya on 04.04.2024.
//

import UIKit
import CoreData

class LogInViewController: UIViewController {
    // MARK: - Services
    
    var routeToProfile: ((UserData) -> ())?
    var routeToRegistration:(()->())?

    
    // MARK: - UI Elements Optimization with Comments
    
    // ScrollView: Обеспечивает прокрутку содержимого.
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .customBackgroundColor
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // ContentView: Контейнер для всех дочерних элементов.
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .customBackgroundColor
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    // LogoView: Отображение логотипа приложения.
    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // LoginView: Поле ввода для логина.
    private lazy var loginView: CustomTextField = {
        let textView = CustomTextField(placeholder: "Email".localized, isSecure: false, cornerRadius: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
        return textView
    }()
    
    // PasswordView: Поле ввода для пароля.
    private lazy var passwordView:  CustomTextField = {
        let textView = CustomTextField(placeholder: "Password".localized, isSecure: false, cornerRadius: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        return textView
    }()

    // LogInButton: Кнопка для выполнения входа.
    private lazy var logInButton: CustomButton = {
        let button = CustomButton(title: "Log In".localized, titleColor: .white){
            self.buttonPressed()
        }
        button.layer.cornerRadius = 10
        button.setBackgroundImage(UIImage(named: "ButtonColor"), for: .normal)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //signUpButton: кнопка для перехода в форму регистрации
    private lazy var signUpButton: CustomButton = {
        let button = CustomButton(title: "Register".localized, titleColor: .color){
            self.signUpAction()
        }
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setupContraints()
        showUsers()
        self.navigationItem.hidesBackButton = true
    }
    
    
    func showUsers() {
            let users = CoreDataManager.shared.fetchAllUsers()
            for user in users {
                print("User: \(user.fullName ?? "Unknown"), Email: \(user.email ?? "Unknown"),pass: \(user.password ?? "no"), Posts: \(String(describing: user.posts?.count)), Feed: \(String(describing: user.feedPosts?.count)) Photo: \(String(describing: user.photos?.count)), FavPosts: \(String(describing: user.likedPosts?.count)), isAuth: \(user.isAuthorized)")
            }
        }
    

    // MARK: - Жизненный цикл контроллера

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        setupKeyboardObservers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        removeKeyboardObservers()
    }
    
    // MARK: - Настройка основного представления
    
    // Устанавливает базовые параметры экрана: цвет фона и настройки навигационной панели.
    private func setupView() {
        view.backgroundColor = .customBackgroundColor
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.backgroundColor = .customBackgroundColor
    }

    // Добавляет все подвиды в иерархию представлений.
    private func addSubviews() {
        // Добавление scrollView на главный view
        view.addSubview(scrollView)
        
        // Добавление UI-элементов в contentView
        [logoView, loginView, passwordView, logInButton, signUpButton].forEach { contentView.addSubview($0) }
        
        // Добавление contentView в scrollView
        scrollView.addSubview(contentView)
    }
   
    // MARK: - Действия пользователя

    // Обрабатывает нажатие кнопки входа.
    private func buttonPressed() {
        
        guard let email = loginView.text, !email.isEmpty,
              let password = passwordView.text, !password.isEmpty else {
            showErrorAlert(message: "Please enter email and password")
            return
        }
        
        switch CoreDataManager.shared.fetchUser(email: email, password: password) {
        case .success(let user):
            // Переход на экран профиля через замыкание
            routeToProfile?(user)
            user.isAuthorized = true
        case .failure(let error):
            showErrorAlert(message: error.localizedDescription)
        }
    }

    // Обрабатывает нажатие кнопки регистрации.
    private func signUpAction() {
            routeToRegistration?()
    }

    // MARK: - Вспомогательные методы


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
            
            passwordView.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: -1),
            passwordView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            passwordView.heightAnchor.constraint(equalToConstant: 50),
            
            logInButton.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            
            signUpButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 8),
            signUpButton.centerXAnchor.constraint(equalTo: logInButton.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 20),
            signUpButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
    
    // MARK: - Управление клавиатурой

    // Изменяет нижний отступ `UIScrollView` при появлении клавиатуры.
    @objc private func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        scrollView.contentInset.bottom = keyboardHeight ?? 0.0
    }

    // Сбрасывает нижний отступ `UIScrollView` при скрытии клавиатуры.
    @objc private func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
    
    // MARK: - Настройка наблюдателей клавиатуры

    // Устанавливает наблюдателей на появление и скрытие клавиатуры.
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(willShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(willHideKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // Удаляет наблюдателей за событиями клавиатуры.
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self)
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



//
//  RegistrationViewController.swift
//  Navigation
//
//  Created by Anastasiya on 20.12.2024.
//

import UIKit

class RegistrationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var routeToProfile: ((UserData) -> ())?
    
    // UI-элементы
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private var avatarFilePath: String?
    
    private lazy var changeAvatarButton: CustomButton = {
        let button = CustomButton(title: "Select an avatar".localized, titleColor: .color){
            self.changeAvatarTapped()
        }
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var emailTextField: CustomTextField = {
        let textView = CustomTextField(placeholder: "Email".localized, isSecure: false, cornerRadius: [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        return textView
    }()
    
    private lazy var firstNameTextField: CustomTextField = {
        let textView = CustomTextField(placeholder: "Name".localized, isSecure: false, cornerRadius: [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        return textView
    }()
    
    private lazy var lastNameTextField: CustomTextField = {
        let textView = CustomTextField(placeholder: "Surename".localized, isSecure: false, cornerRadius: [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        return textView
    }()
    
    private lazy var passwordTextField: CustomTextField = {
        let textView = CustomTextField(placeholder: "Password".localized, isSecure: true, cornerRadius: [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        return textView
    }()
    
    private lazy var confirmPasswordTextField: CustomTextField = {
        let textView = CustomTextField(placeholder: "Confirm your password".localized, isSecure: true, cornerRadius: [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        return textView
    }()
    
    
    private lazy var registerButton: CustomButton = {
        let button = CustomButton(title: "Register".localized, titleColor: .white){
            self.registerTapped()
        }
        button.layer.cornerRadius = 10
        button.setBackgroundImage(UIImage(named: "ButtonColor"), for: .normal)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBackgroundColor
        setupView()
        navigationController?.navigationBar.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    
    private func setupView() {
        view.addSubview(avatarImageView)
        view.addSubview(changeAvatarButton)
        view.addSubview(emailTextField)
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            changeAvatarButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            changeAvatarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: changeAvatarButton.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            
            firstNameTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
            firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 12),
            lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 12),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 12),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            registerButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 20),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func changeAvatarTapped() {
        // Проверяем, доступен ли доступ к фото
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true // позволяет редактировать фото
            self.present(picker, animated: true, completion: nil)
        }
    }
    // Данный метод будет вызван после выбора фото из галереи
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Получаем выбранное фото
        if let selectedImage = info[.editedImage] as? UIImage {
            avatarImageView.image = selectedImage
            //            avatarFilePath = saveImageToDocumentsDirectory(image: selectedImage)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Этот метод вызывается, если пользователь отменяет выбор
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func registerTapped() {
        
        guard let email = emailTextField.text, !email.isEmpty,
              let firstName = firstNameTextField.text, !firstName.isEmpty,
              let lastName = lastNameTextField.text, !lastName.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let avatarImage = avatarImageView.image,
              let avatarData = avatarImage.jpegData(compressionQuality: 0.8)
        else {
            showErrorAlert(message: "Please fill in all fields")
            return
        }
//        let fullName = "\(firstName) \(lastName)"
        
        if password == confirmPasswordTextField.text!{
            
            // Используем CoreDataManager для создания пользователя
            switch CoreDataManager.shared.createUser(email: email, firstName: firstName, lastName: lastName, password: password, avatar: avatarData) {
            case .success(let newUser):
                // После успешной регистрации вызываем замыкание для маршрутизации на профиль
                
                routeToProfile?(newUser)
                newUser.isAuthorized = true
                
                showSuccessAlert(message: "User successfully registered")
            case .failure(let error):
                showErrorAlert(message: error.localizedDescription)
            }
        }else{
            showErrorAlert(message: "Passwords do not match")
            confirmPasswordTextField.text = ""
        }
        
    }
    
    
    
}



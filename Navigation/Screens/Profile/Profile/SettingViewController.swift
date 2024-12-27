//
//  SettingViewController.swift
//  Navigation
//
//  Created by Anastasiya on 27.12.2024.
//

import UIKit

class SettingViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    weak var delegate: ProfileSettingsDelegate?
    // Модель пользователя
    var currentUser: UserData?
    
    // UI элементы
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50 // Круглый аватар
        imageView.backgroundColor = .systemGray5
        imageView.image = UIImage(systemName: "person.circle")
        return imageView
    }()
    
    private let changePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Изменить фото", for: .normal)
        return button
    }()
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Имя"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Фамилия"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Статус"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сохранить", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        loadUserData()
    }
    
    // Настройка интерфейса
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Добавление элементов на экран
        view.addSubview(avatarImageView)
        view.addSubview(changePhotoButton)
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(statusTextField)
        view.addSubview(saveButton)
        
        // Расстановка элементов
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            changePhotoButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),
            changePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            firstNameTextField.topAnchor.constraint(equalTo: changePhotoButton.bottomAnchor, constant: 20),
            firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 10),
            lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            statusTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 10),
            statusTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            saveButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // Настройка действий
    private func setupActions() {
        changePhotoButton.addTarget(self, action: #selector(changePhotoTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    // Загрузка данных пользователя
    
    private func loadUserData() {
        guard let user = currentUser else { return }
        
        firstNameTextField.text = user.firstName
        lastNameTextField.text = user.lastName
        statusTextField.text = user.status
        
        if let avatarData = user.avatar {
            avatarImageView.image = UIImage(data: avatarData)
        }
    }
    
    // Обработчик изменения фото
    @objc private func changePhotoTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    // Обработчик сохранения данных
    @objc private func saveButtonTapped() {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
              let lastName = lastNameTextField.text, !lastName.isEmpty,
              let status = statusTextField.text, !status.isEmpty else {
            showErrorAlert(message: "Заполните все поля")
            return
        }
        
        // Обновляем текущего пользователя
        guard let user = currentUser else { return }
        
        user.firstName = firstName
        user.lastName = lastName
        user.fullName = firstName + " " + lastName
        user.status = status
        
        if let avatarImage = avatarImageView.image {
            user.avatar = avatarImage.jpegData(compressionQuality: 0.8)
        }
        
        // Сохраняем изменения в Core Data
        do {
            try CoreDataManager.shared.saveContext()
            delegate?.didUpdateProfile(user: user) // Уведомляем делегата
            dismiss(animated: true)
            showSuccessAlert(message: "Данные профиля сохранены")
        } catch {
            showErrorAlert(message: "Не удалось сохранить изменения: \(error.localizedDescription)")
        }
    }
    
    
}

extension SettingViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        if let selectedImage = info[.originalImage] as? UIImage {
            avatarImageView.image = selectedImage
        }
    }
}

protocol ProfileSettingsDelegate: AnyObject {
    func didUpdateProfile(user: UserData)
}

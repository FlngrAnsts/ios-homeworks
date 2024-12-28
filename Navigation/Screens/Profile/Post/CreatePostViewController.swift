//
//  CreatePostViewController.swift
//  Navigation
//
//  Created by Anastasiya on 27.12.2024.
//

import UIKit
protocol CreatePostDelegate: AnyObject {
    func didCreatePost(_ post: PostData)
}
class CreatePostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    weak var delegate: CreatePostDelegate?
    // MARK: - Properties
    var currentUser: UserData? // The user creating the post
    
    private let postDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .lightGray
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 8
        textView.clipsToBounds = true
        textView.text = "Enter your post description here..."
        textView.isEditable = true
        return textView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.layer.cornerRadius = 8
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "photo.on.rectangle")
        imageView.tintColor = .systemGray4
        return imageView
    }()
    
    private let createPostButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create Post", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(createPostTapped), for: .touchUpInside)
        return button
    }()
    
    private let imagePicker = UIImagePickerController()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        imagePicker.delegate = self
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Create Post"
        
        // Add subviews
        view.addSubview(postDescriptionTextView)
        view.addSubview(imageView)
        view.addSubview(createPostButton)
        
        // Layout
        postDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        createPostButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            postDescriptionTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            postDescriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            postDescriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            postDescriptionTextView.heightAnchor.constraint(equalToConstant: 100),
            
            imageView.topAnchor.constraint(equalTo: postDescriptionTextView.bottomAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            
            createPostButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            createPostButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createPostButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createPostButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupActions() {
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(imageTapGesture)
        
        postDescriptionTextView.delegate = self
    }
    
    // MARK: - Actions
    @objc private func imageTapped() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    @objc private func createPostTapped() {
        guard currentUser != nil else {
                print("User not set!")
                return
            }
            
            let description = postDescriptionTextView.text
            let imageData = imageView.image == UIImage(systemName: "photo.on.rectangle") ? nil : imageView.image?.pngData()
            
            // Validate that at least one of the fields (text or image) is provided
            if (description == nil || description!.isEmpty || description == "Enter your post description here...") && imageData == nil {
                print("Cannot create a post without text or an image")
                showErrorAlert(message: "Please provide either a description or an image.")
                
                return
            }
            
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = dateFormatter.string(from: currentDate)
            
            let newPost = CoreDataManager.shared.addPost(
                author: currentUser?.fullName ?? "",
                date: dateString,
                image: imageData ?? Data(),
                postDescription: description ?? ""
            )
        
        currentUser?.addToPosts(newPost)
        delegate?.didCreatePost(newPost)
            print("Post created successfully")
        dismiss(animated: true)
//            navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }

}

extension CreatePostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter your post description here..."
            textView.textColor = .lightGray
        }
    }
}

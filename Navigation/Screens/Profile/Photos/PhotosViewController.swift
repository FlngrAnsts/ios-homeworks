//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Anastasiya on 28.05.2024.
//

import UIKit
import iOSIntPackage
import CoreData

class PhotosViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var currentUser: UserData?
    var profilePhotos: [PhotoData] = []
    
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        setupLayouts()
        fetchPhotosFromCoreData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        fetchPhotosFromCoreData()
//        collectionView.reloadData()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
        }
    
    
    private func setupView() {
        view.backgroundColor = .customBackgroundColor
        title = "Photo Gallery".localized
        let addPhotoButton = UIBarButtonItem(image: UIImage(systemName: "plus.square"), style: .done, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addPhotoButton
        addPhotoButton.tintColor = UIColor.customTextColor
        
    }
    
    private func setupSubviews() {
        setupCollectionView()
        
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .customBackgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupLayouts() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
        ])
    }
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 8.0
    }
    
    @objc private func addButtonTapped(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    private func fetchPhotosFromCoreData() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<PhotoData> = PhotoData.fetchRequest()
        
        do {
            profilePhotos = try context.fetch(fetchRequest)
            
            
            collectionView.reloadData()
        } catch {
            print("Failed to fetch photos: \(error.localizedDescription)")
        }
    }
    
    private func savePhotoToCoreData(image: UIImage) {
        guard currentUser != nil else {
                return
            }
        guard let imageData = image.pngData() else { return }
        let date = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short)
        let photo = CoreDataManager.shared.addPhoto(date: date, image: imageData)
        currentUser?.addToPhotos(photo)
//        collectionView.reloadData()
    }

    
    // MARK: - UIImagePickerControllerDelegate
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            savePhotoToCoreData(image: selectedImage)
        }
        dismiss(animated: true){ [weak self] in
            self?.fetchPhotosFromCoreData() // Обновление контента после закрытия
        }
    }
    
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         dismiss(animated: true)
    }
    
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return profilePhotos.count
        }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotosCollectionViewCell.identifier,
            for: indexPath) as! PhotosCollectionViewCell
        
        let imageData = profilePhotos[indexPath.item]
            cell.configure(with: imageData) // Настройка ячейки
        
        return cell
        
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private func itemWidth(
        for width: CGFloat,
        spacing: CGFloat
    ) -> CGFloat {
        let itemsInRow: CGFloat = 3
        
        let totalSpacing: CGFloat = 3 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        
        return floor(finalWidth)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = itemWidth(
            for: view.frame.width,
            spacing: LayoutConstant.spacing
        )
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
            top: LayoutConstant.spacing,
            left: LayoutConstant.spacing,
            bottom: LayoutConstant.spacing,
            right: LayoutConstant.spacing
        )
    }
    
}




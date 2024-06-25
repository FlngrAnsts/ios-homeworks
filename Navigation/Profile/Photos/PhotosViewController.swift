//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Anastasiya on 28.05.2024.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {

    fileprivate lazy var photos: [Photo] = Photo.make()
    
    lazy var images: [UIImage] = photos.map({UIImage(named: $0.image) ?? UIImage()})
    
    var coordinator: ProfileCoordinator?
    
    //lazy var images: [UIImage] = []
    
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
        
//        processImage()
        processImageOfThresd()

    }
    
    
    func processImageOfThresd(){
        
        let startTime = CFAbsoluteTimeGetCurrent()
        
        ImageProcessor().processImagesOnThread(
            sourceImages: photos.map({UIImage(named: $0.image) ?? UIImage()}),
            filter: .noir,
            qos: .background)
        { [weak self] cgImages in
            self?.images = cgImages.compactMap{$0}.map{UIImage(cgImage: $0)}
            
            let stopTime = CFAbsoluteTimeGetCurrent()
                print("Code execution time: \(stopTime-startTime) s.")
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            let navigationBar = self.navigationController?.navigationBar
            navigationBar?.tintColor = .systemBlue
            navigationBar?.barStyle = .default

        }
    

        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            
        }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Photo Gallery"
        
    }
    
    private func setupSubviews() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
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
}



extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        images.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotosCollectionViewCell.identifier,
            for: indexPath) as! PhotosCollectionViewCell
        
//        let photo = photos[indexPath.row]
//        cell.setup(with: photo)
        
        let image = images[indexPath.row]
        cell.setupImg(image: image)
        
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

//extension PhotosViewController: ImageLibrarySubscriber {
//    func receive(images: [UIImage]) {
//        images = images
//        collectionView.reloadData()
//    }
//    
//}



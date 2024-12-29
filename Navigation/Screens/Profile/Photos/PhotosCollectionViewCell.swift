//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Anastasiya on 28.05.2024.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    private lazy var collectionImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.backgroundColor = .customBackgroundColor
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
        setupSubviews()
        setupLayouts()
    }
    private func setupView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .customBackgroundColor
    }
    
    private func setupSubviews() {
        contentView.addSubview(collectionImageView)
        
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            collectionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
    
    func configure(with image: PhotoData) {
        if (image.image != nil){
            collectionImageView.image = UIImage(data: image.image!)
        }
        
        }
    
}

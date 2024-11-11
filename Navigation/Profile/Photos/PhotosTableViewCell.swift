//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Anastasiya on 28.05.2024.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    static let cellID = "PhotosTableViewCell"
    var buttonTapCallback: () -> () = {}
    
    private enum Constants{
        static let cornerRadius = 6
        static let photoWidth = (UIScreen.main.bounds.width - (12+8+8+8+12))/4
    }

    private lazy var collectionTitle: UILabel={
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .customTextColor
        label.font = .boldSystemFont(ofSize: 24)
        
        label.text = "Photos"
        
        return label
    }()
    
    private lazy var arrow: UIButton = {
        let arrow = UIButton(type: .custom)
        arrow.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        arrow.addTarget(self, action: #selector(tapArrow(_:)), for: .touchUpInside)
        arrow.translatesAutoresizingMaskIntoConstraints = false
        
        return arrow
    }()
    
    @objc func tapArrow(_: UIResponder){
        buttonTapCallback()
    }
    
    private lazy var collectionImageView_1: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "Image_1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var collectionImageView_2: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "Image_2")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var collectionImageView_3: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "Image_3")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var collectionImageView_4: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "Image_4")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
            )

            tuneView()
            addSubviews()
            setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tuneView(){
        
        contentView.backgroundColor = .customBackgroundColor
        accessoryType = .none
        
    }
    
    private func addSubviews(){
        contentView.addSubview(collectionTitle)
        contentView.addSubview(arrow)
        contentView.addSubview(collectionImageView_1)
        contentView.addSubview(collectionImageView_2)
        contentView.addSubview(collectionImageView_3)
        contentView.addSubview(collectionImageView_4)
       
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            collectionTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            collectionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            collectionTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
           
            
            arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrow.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            arrow.centerYAnchor.constraint(equalTo: collectionTitle.centerYAnchor),
            
            
            collectionImageView_1.topAnchor.constraint(equalTo: collectionTitle.bottomAnchor, constant: 12),
            collectionImageView_1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            collectionImageView_1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            collectionImageView_1.widthAnchor.constraint(equalToConstant: Constants.photoWidth),
            collectionImageView_1.heightAnchor.constraint(equalToConstant: Constants.photoWidth),
            

            collectionImageView_2.leadingAnchor.constraint(equalTo: collectionImageView_1.trailingAnchor, constant: 8),
            collectionImageView_2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            collectionImageView_2.widthAnchor.constraint(equalToConstant: Constants.photoWidth),
            collectionImageView_2.heightAnchor.constraint(equalToConstant: Constants.photoWidth),
            

            collectionImageView_3.leadingAnchor.constraint(equalTo: collectionImageView_2.trailingAnchor, constant: 8),
            collectionImageView_3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            collectionImageView_3.widthAnchor.constraint(equalToConstant: Constants.photoWidth),
            collectionImageView_3.heightAnchor.constraint(equalToConstant: Constants.photoWidth),
            
            
            collectionImageView_4.leadingAnchor.constraint(equalTo: collectionImageView_3.trailingAnchor, constant: 8),
            collectionImageView_4.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            collectionImageView_4.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            collectionImageView_4.widthAnchor.constraint(equalToConstant: Constants.photoWidth),
            collectionImageView_4.heightAnchor.constraint(equalToConstant: Constants.photoWidth),
            
            ])
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

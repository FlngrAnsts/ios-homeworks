//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Anastasiya on 15.05.2024.
//

import UIKit
import Foundation

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Статические свойства
    static let cellID = "PostTableViewCell"
    
    // MARK: - Приватные свойства
    private var profile: UserData?
    private var postInCell: PostData?
    private var likeTotal: Int?
    
    // MARK: - UI Элементы
    lazy var authorLabelView: CustomLabel = {
        let label = CustomLabel(fontSize: 20, textColor: .customTextColor)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .customPhotoBackgroundColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var postTextView: CustomLabel = {
        let label = CustomLabel(fontSize: 16, textColor: .customTextColor)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        
        let button =  CustomButton(title: "", titleColor: .customTextColor, action: changerLike)
        button.imageView?.tintColor = .customTextColor
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var postDateViewsView: CustomLabel = {
        let label = CustomLabel(fontSize: 16, textColor: .customTextColor)
        
        return label
    }()
    
    // MARK: - Инициализатор
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupSubviews()
        setupConstraints()  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Методы настройки
    private func setupView() {
        contentView.backgroundColor = .customBackgroundColor
        accessoryType = .none
    }
    
    private func setupSubviews() {
        contentView.addSubview(authorLabelView)
        contentView.addSubview(postImageView)
        contentView.addSubview(postTextView)
        contentView.addSubview(likeButton)
        contentView.addSubview(postDateViewsView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            authorLabelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorLabelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            authorLabelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            postImageView.topAnchor.constraint(equalTo: authorLabelView.bottomAnchor, constant: 8),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            postImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            postTextView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
            postTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            likeButton.topAnchor.constraint(equalTo: postTextView.bottomAnchor, constant: 8),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            postDateViewsView.topAnchor.constraint(equalTo: postTextView.bottomAnchor, constant: 16),
            postDateViewsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postDateViewsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    // MARK: - Обработка нажатия на кнопку лайка
    private lazy var changerLike: (() -> Void) = { [weak self] in
        self?.toggleLike()
    }
    
    private func toggleLike() {
        guard let user = profile, let post = postInCell else { return }
        CoreDataManager.shared.likePost(user: user, post: post)
        updateLikeUI()
    }
    
    // Обновление UI кнопки лайка
    private func updateLikeUI() {
        guard let postData = postInCell else { return }
        likeButton.setTitle("\(postData.likes)", for: .normal)
        let heartImage = postData.isLiked ? "suit.heart.fill" : "suit.heart"
        likeButton.setImage(UIImage(systemName: heartImage), for: .normal)
    }
    
    
    func getUser(with user: UserData){
        profile = user
    }
    
    func update(with post: PostData) {
        postInCell = post
        authorLabelView.text = post.author
        if (post.image != nil){
            postImageView.image = UIImage(data: post.image! )
        } else {
            postImageView.image = nil
        }
        postTextView.text = post.postDescription
        likeTotal = Int(post.likes)
        postDateViewsView.text = post.date
        
        updateLikeUI()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UITableView.automaticDimension)
    }
    
}

//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Anastasiya on 15.05.2024.
//

import UIKit
import CoreData
import StorageService

class PostTableViewCell: UITableViewCell {
    
    static let cellID = "PostTableViewCell"
    private var postInCell: PostData?
    private var profile: UserData?
    private var likeButtonCheck = false
    private var likeTotal = 0
    
    lazy var postTitleView: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .customTextColor
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .customTextColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var postTextView: UILabel = {
        let text = UILabel()
        
        text.font = UIFont.systemFont(ofSize: 14)
        text.textColor = .customTextColor
        text.numberOfLines = 0
        
        text.translatesAutoresizingMaskIntoConstraints = false
        
        return text
    }()
    
//    lazy var postLikesView: UILabel = {
//        let text = UILabel()
//        
//        text.font = UIFont.systemFont(ofSize: 16)
//        text.textColor = .customTextColor
//        text.translatesAutoresizingMaskIntoConstraints = false
//        
//        return text
//    }()
    
    private lazy var likeButton: UIButton = {
        let button = CustomButton(title: "\(likeTotal)", titleColor: .customTextColor, action: changerLike)
        button.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        button.imageView?.tintColor = .customTextColor
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var postViewsView: UILabel = {
        let text = UILabel()
        
        text.font = UIFont.systemFont(ofSize: 16)
        text.textColor = .customTextColor
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
                reuseIdentifier: String?
    ){
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
        contentView.addSubview(postTitleView)
        contentView.addSubview(postImageView)
        contentView.addSubview(postTextView)
        contentView.addSubview(likeButton)
        contentView.addSubview(postViewsView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            postTitleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postTitleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postTitleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
           
            postImageView.topAnchor.constraint(equalTo: postTitleView.bottomAnchor, constant: 16),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            postImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            postTextView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
            postTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            likeButton.topAnchor.constraint(equalTo: postTextView.bottomAnchor, constant: 16),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            postViewsView.topAnchor.constraint(equalTo: postTextView.bottomAnchor, constant: 16),
            postViewsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postViewsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ])
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    private lazy var changerLike: (() -> Void) = {
        self.changeLike()
    }
    
    private func changeLike() {
        if likeButtonCheck == false {
            likeButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
            likeTotal += 1
            likeButton.setTitle("\(likeTotal)", for: .normal)
            likeButtonCheck = true
        } else {
            likeButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
            likeTotal -= 1
            likeButton.setTitle("\(likeTotal)", for: .normal)
            likeButtonCheck = false
        }
    }
    
    func update(_ model: Post) {
        postTitleView.text = model.author
        postImageView.image = UIImage(named: model.image)
        postTextView.text = model.postDescription
//        likeButton.text = "Likes: \(model.likes)"
        postViewsView.text = "Views: \(model.views)"
        
    }
    
    func update(_ model: LikePost) {
        postTitleView.text = model.author
        postImageView.image = UIImage(named: model.image ?? "")
        postTextView.text = model.postDescription
//        postLikesView.text = "Likes: \(model.likes)"
        postViewsView.text = "Views: \(model.views)"
        
    }
    
    override var intrinsicContentSize: CGSize {
            CGSize(
                width: UIView.noIntrinsicMetric,
                height: 1000
            )
        }

}

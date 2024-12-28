//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Anastasiya on 15.05.2024.
//

import UIKit
import Foundation

class PostTableViewCell: UITableViewCell {
    
    static let cellID = "PostTableViewCell"
    private var profile: UserData?
    private var postInCell: PostData?
    private var likeButtonCheck = false
    private var likeTotal: Int?
    
    lazy var authorLabelView: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .customTextColor
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var postTextView: UILabel = {
        let text = UILabel()
        
        text.font = UIFont.systemFont(ofSize: 14)
        text.textColor = .customTextColor
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        text.textAlignment = .left
        
        text.translatesAutoresizingMaskIntoConstraints = false
        
        return text
    }()
    
    private lazy var likeButton: UIButton = {

        let button =  CustomButton(title: "", titleColor: .customTextColor, action: changerLike)
        button.imageView?.tintColor = .customTextColor
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var postDateViewsView: UILabel = {
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

    private lazy var changerLike: (() -> Void) = {
        self.changeLike()
    }
    
    private func changeLike() {
        guard let user = profile else { return }
        guard let post = postInCell else { return }
        CoreDataManager.shared.likePost(user: user, post: post)
        updateLikeUI()
       }

       private func updateLikeUI() {
           guard let postData = postInCell else { return }
           self.likeButton.setTitle("\(postData.likes)", for: .normal)
           let heartImage = postData.isLiked ? "suit.heart.fill" : "suit.heart"
           self.likeButton.setImage(UIImage(systemName: heartImage), for: .normal)
       }
    
    
    func getUser(with user: UserData){
        profile = user
    }
    
    
    func updateProfile(with post: PostData) {
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
    
    func update(_ post: PostData) {
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

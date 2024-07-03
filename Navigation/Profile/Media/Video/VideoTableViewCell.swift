//
//  VideoTableViewCell.swift
//  Navigation
//
//  Created by Anastasiya on 03.07.2024.
//

import UIKit
import AVFoundation
import WebKit

class VideoTableViewCell: UITableViewCell {
    
    static let cellID = "VideoTableViewCell"
    
//    var video: Video? = nil
    
    var buttonTapVideoCallback: () -> () = {}
    
    lazy var labelView: UIButton = {
        let label = UIButton()
        
//        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.clipsToBounds = true

        label.setTitle("", for: .normal)
        label.setTitleColor(.black, for: .normal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.addTarget(self, action: #selector(tapVideoButton(_:)), for: .touchUpInside)
        
        return label
    }()
    
    @objc func tapVideoButton(_: UIResponder){
        buttonTapVideoCallback()
    }

//    lazy var contentImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.backgroundColor = .black
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
//    lazy var contentVideoView: UIView = {
//        let content = UIView()
//        return content
//    }()
    
    override var intrinsicContentSize: CGSize {
        CGSize(
            width: UIView.noIntrinsicMetric,
            height: 1000
        )
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        tuneView()
        addSubviews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tuneView(){
        
        contentView.backgroundColor = .white
        accessoryType = .none
        
    }
    
    private func addSubviews(){
        contentView.addSubview(labelView)
//        contentView.addSubview(contentVideoView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            labelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            labelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                
            ])
    }
    
    func update(_ model: Video) {
        
        labelView.setTitle(model.label, for: .normal)
        
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

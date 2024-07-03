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
    
    var video: Video? = nil
    
    lazy var labelView: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    lazy var contentVideoView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    
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
            labelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            labelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            labelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            
//            contentVideoView.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 16),
//            contentVideoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            contentVideoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            contentVideoView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
//            contentVideoView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
        ])
    }
    
    func update(_ model: Video) {
        labelView.text = model.label
        
//        let queue = DispatchQueue(label: "video", qos:
//                .default)
//        queue.async {
//            let image = self.createThumbnailOfVideoFromRemoteUrl(url:  model.url)
//            DispatchQueue.main.async {
//                if let image = image{
//                    self.contentVideoView.image = image
//                }
//                
//            }
//        }
        
    }
    
    func createThumbnailOfVideoFromRemoteUrl(url: String) -> UIImage? {
        let asset = AVAsset(url: URL(string: url)!)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 60)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
            print(error.localizedDescription)
            return nil
        }
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

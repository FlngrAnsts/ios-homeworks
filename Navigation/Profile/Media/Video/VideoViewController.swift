//
//  VideoViewController.swift
//  Navigation
//
//  Created by Anastasiya on 03.07.2024.
//

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController {
    
    fileprivate var videoList = Video.make()
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .plain
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.isUserInteractionEnabled = true
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
        tuneTableView()
        
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
        title = "Video"
    }
    
    private func addSubviews(){
        view.addSubview(tableView)
    }
    
    private func setupConstraints(){
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
        ])
    }
    
    private func tuneTableView(){
        
        tableView.register(
            VideoTableViewCell.self,
            forCellReuseIdentifier: VideoTableViewCell.cellID
        )
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    
}


extension VideoViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        videoList.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        //рисует ячейку постов
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: VideoTableViewCell.cellID,
            for: indexPath
        ) as? VideoTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        
        cell.update(videoList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let videoPath = Bundle.main.path(forResource: videoList[indexPath.row].url, ofType: "mp4")
        else {
            print("ERROR")
            return
        }
        let videoUrl = URL(filePath: videoPath)
        let player = AVPlayer(url: videoUrl)
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsTimecodes = true
        present(controller, animated: true) {
            player.play()
        }
        
    }
    
}

extension VideoViewController: UITableViewDelegate {}

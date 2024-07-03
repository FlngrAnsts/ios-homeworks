//
//  VideoViewController.swift
//  Navigation
//
//  Created by Anastasiya on 03.07.2024.
//

import UIKit
import AVFoundation
import AVKit
import WebKit

class VideoViewController: UIViewController, WKUIDelegate {
    
    lazy var videoList = Video.make()
    
    var webView: WKWebView!
        
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
//        view.addSubview(webView)
        view = webView
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .grouped
        )
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.isUserInteractionEnabled = true
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupView()
//        addSubviews()
//        setupConstraints()
//        tuneTableView()

//        view.addSubview(webView)
        let myURL = URL(string: videoList[0].url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
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
//        tableView.tableFooterView = UIView()
        
        tableView.register(
            VideoTableViewCell.self,
            forCellReuseIdentifier: VideoTableViewCell.cellID
        )
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
//    func playVideo(){
//        let url = URL(string: videoList[indexPath.row].url)
//        
//        if let url = url {
//            let player = AVPlayer(url: url)
//            
//            let controller = AVPlayerViewController()
//            controller.player = player
//            
//            present(controller, animated: true) {
//                player.play()
//            }
//        }
//    }
    
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
//        cell.buttonTapVideoCallback =
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: videoList[indexPath.row].url)
        
        //        let myURL = URL(string: videoList[1].url)
                let myRequest = URLRequest(url: url!)
                webView.load(myRequest)
        
        if let url = url {
            let player = AVPlayer(url: url)
            
            let controller = AVPlayerViewController()
            controller.player = player
            
            present(controller, animated: true) {
                player.play()
            }
        }
    }
    
}

extension VideoViewController: UITableViewDelegate {}

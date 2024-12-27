//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Anastasiya on 28.03.2024.
//

import UIKit
import CoreData


class ProfileViewController: UIViewController, ProfileSettingsDelegate  {

//    private var coreDataService = CoreDataManager.shared
    
    var currentUser: UserData?
    var routeToPhoto: () -> () = {}
    var routeToLogin: (()->())?
    private let profileHeaderView = ProfileHeaderView()
    
    fileprivate var data = Post.make()
  
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    init(user: UserData) {
        self.currentUser = user
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        setupView()
        addSubviews()
        setupConstraints()
        tuneTableView()
        
        loadUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        print("tapped")
    }

    private func setupView(){
        self.view.backgroundColor = .customBackgroundColor
        self.navigationController?.navigationBar.isHidden = false
        let logoutButton = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.fill.badge.xmark"), style: .done, target: self, action: #selector(logoutButtonTapped))
        navigationItem.rightBarButtonItem = logoutButton
        logoutButton.tintColor = UIColor.customTextColor
        self.navigationItem.hidesBackButton = true
        
    }
    
    @objc private func logoutButtonTapped() {
        routeToLogin?()
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
    
    private func audioVC(){
        
        let audioVC = AudioViewController()
        self.navigationController?.pushViewController(audioVC, animated: true)
    }
    
    private func photosVC(){
        let viewController = PhotosViewController()
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func videoVC(){
        let videoVC = VideoViewController()
        
        self.navigationController?.pushViewController(videoVC, animated: true)
    }
    
    private func audioRecVC(){
        let audioRecVC = AudioRecVideoViewController()
        
        self.navigationController?.pushViewController(audioRecVC, animated: true)
    }
    
    func settingVC(){
        let profileVC = SettingViewController()
        profileVC.currentUser = currentUser
        profileVC.delegate = self
        present(profileVC, animated: true)
    }
    private func loadUserData() {
        // Загружаем данные текущего пользователя из Core Data
        if let user = currentUser {
            profileHeaderView.update(with: user)
        }
    }

    func didUpdateProfile(user: UserData) {
        currentUser = user
        profileHeaderView.update(with: user)
    }
    
    private func tuneTableView(){
        let headerView = profileHeaderView
        headerView.buttonSettingCallback = settingVC
        tableView.tableHeaderView = profileHeaderView
        
        tableView.setAndLayout(headerView: headerView)
        
        tableView.tableFooterView = UIView()
        
        
        tableView.register(
            PhotosTableViewCell.self,
            forCellReuseIdentifier: PhotosTableViewCell.cellID
        )
        
        tableView.register(
            MediaTableViewCell.self,
            forCellReuseIdentifier: MediaTableViewCell.cellID
        )
        
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: PostTableViewCell.cellID
        )
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
}


extension ProfileViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        data.count + 2
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        //Рисуем первую (нулевую ячейку)
        if (indexPath.row == 0) {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PhotosTableViewCell.cellID,
                for: indexPath
            ) as? PhotosTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            cell.buttonTapCallback = routeToPhoto
            
            return cell
        }
        //        ячейка медиа
        if (indexPath.row == 1) {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MediaTableViewCell.cellID,
                for: indexPath
            ) as? MediaTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            cell.buttonTapAudioCallback = audioVC
            cell.buttonTapVideoCallback = videoVC
            cell.buttonTapRECCallback = audioRecVC
            
            return cell
        }
        //рисует ячейку постов
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.cellID,
            for: indexPath
        ) as? PostTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
//        if cell.gestureRecognizers == nil {
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
//            tapGesture.numberOfTapsRequired = 2
//            cell.addGestureRecognizer(tapGesture)
//        }
        
        cell.update(data[indexPath.row-2])
        
        return cell
    }
    
//    @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
//        if let cell = gesture.view as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
//            
//            
//            
//            print("Double tap")
//            LikeDataManager.shared.addLikePost(post: data[indexPath.row-2])
//        }
//    }
}

extension ProfileViewController: UITableViewDelegate {}

//extension ProfileViewController: ProfileSettingsDelegate {
//    func didUpdateProfile(user: UserData) {
//        // Обновляем интерфейс
//        self.user = user
//        self.updateUI()
//    }
//    
//    private func updateUI() {
//        // Обновляем данные на экране
//        nameLabel.text = user?.fullName
//        statusLabel.text = currentUser?.status
//        if let avatarData = currentUser?.avatar {
//            avatarImageView.image = UIImage(data: avatarData)
//        }
//    }
//}


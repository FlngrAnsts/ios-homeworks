//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Anastasiya on 28.03.2024.
//

import UIKit
import CoreData


class ProfileViewController: UIViewController, ProfileSettingsDelegate, CreatePostDelegate  {
    func didCreatePost(_ post: PostData) {
        postDataArray.insert(post, at: 0)
        tableView.reloadData()
    }
    

    var currentUser: UserData?
    var routeToPhoto: (()->())?
    var routeToLogin: (()->())?
    private let profileHeaderView = ProfileHeaderView()
    // Массив постов пользователя
    var postDataArray: [PostData] = []
    var photoArray: [PhotoData] = []
    
    
    init(user: UserData) {
        self.currentUser = user
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
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
        loadPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPosts()
        fetchPhotosFromCoreData()
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
    func loadPosts() {
        if let postsSet = currentUser!.posts as? Set<PostData> {
            
            // Convert the NSSet (or Set) to an array
            var postsArray = Array(postsSet)
            
            // Sort the posts by the date in descending order (newest first)
            postsArray.sort { (post1, post2) -> Bool in
                // Convert the date strings to Date objects for comparison
                if let date1 = post1.date, let date2 = post2.date {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Adjust format if necessary
                    if let formattedDate1 = dateFormatter.date(from: date1),
                       let formattedDate2 = dateFormatter.date(from: date2) {
                        return formattedDate1 > formattedDate2 // Newest post first
                    }
                }
                return false
            }
            
            // Assign the sorted posts back to the array
            postDataArray = postsArray
            
            tableView.reloadData()  // Assuming you have a tableView set up
        } else {
            print("No posts found.")
        }
//        self.tableView.reloadData()
    }
    
    private func fetchPhotosFromCoreData() {
        if let photoSet = currentUser!.photos as? Set<PhotoData> {
            
            var photo = Array(photoSet)
            photoArray = Array(photo)
            
            tableView.reloadData()  // Assuming you have a tableView set up
        } else {
            print("No posts found.")
        }
    }
    
    private func loadUserData() {
        // Загружаем данные текущего пользователя из Core Data
            profileHeaderView.setupProfile(user: currentUser!)
    }

    func didUpdateProfile(user: UserData) {
        currentUser = user
        profileHeaderView.setupProfile(user: user)
        tableView.reloadData()
    }
    
    func settingVC(){
        let viewController = SettingViewController()
        viewController.currentUser = currentUser
        viewController.delegate = self
        present(viewController, animated: true)
    }
    
    func createPostVC(){
        let viewController = CreatePostViewController()
        viewController.currentUser = currentUser
        viewController.delegate = self
        present(viewController, animated: true)
    }
    
    private func tuneTableView(){
        let headerView = profileHeaderView
        headerView.buttonSettingCallback = settingVC
        headerView.buttonPostCallback = createPostVC
        tableView.tableHeaderView = profileHeaderView
        tableView.setAndLayout(headerView: headerView)
        tableView.tableFooterView = UIView()
        
        tableView.register(
            PhotosTableViewCell.self,
            forCellReuseIdentifier: PhotosTableViewCell.cellID
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
    
    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDataArray.count + 1
    }
    
    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Рисуем первую (нулевую ячейку)
        if (indexPath.row == 0) {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PhotosTableViewCell.cellID,
                for: indexPath
            ) as? PhotosTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            let photos = photoArray
            cell.create(with: photos)
            cell.buttonTapCallback = routeToPhoto
            
            return cell
        }

        //рисует ячейку постов
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.cellID,
            for: indexPath
        ) as? PostTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        let user = currentUser 
        cell.getUser(with: user!)
        let post = postDataArray[indexPath.row - 1]
        cell.updateProfile(with: post)
        return cell
    }

}


extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Get the post to be deleted
            let postToDelete = postDataArray[indexPath.row - 1] 
            
            // Remove the post from the data array
            postDataArray.remove(at: indexPath.row - 1)
            // Delete the post from Core Data
            CoreDataManager.shared.deletePost(by: postToDelete)
            
            // Delete the row from the table view
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}


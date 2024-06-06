//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Anastasiya on 28.03.2024.
//

import UIKit
import StorageService

//protocol profileVIewControllerDelegate: AnyObject {
//    func scrollOn()
//    func scrollOff()
//}
//
//extension ProfileViewController: profileVIewControllerDelegate {
//
//    func scrollOn() {
//        self.tableView.isScrollEnabled = true
//        self.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = true
//    }
//    
//    func scrollOff() {
//        self.tableView.isScrollEnabled = false
//        self.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = false
//    }
//}

class ProfileViewController: UIViewController {
    
    var user: User?
    
    
    fileprivate let data = Post.make()
    
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
        
        // 1. Задаем размеры и позицию tableView
        setupConstraints()
        tuneTableView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.beginAppearanceTransition(true, animated: true)
        self.endAppearanceTransition()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    private func setupView(){
        
#if DEBUG
        self.view.backgroundColor = .systemGray4
#else
        self.view.backgroundColor = .systemGray6
#endif
        self.navigationController?.navigationBar.isHidden = true
        
        
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
        
        let headerView = ProfileHeaderView()
        if let user = user{
            headerView.setupProfile(user: user)
        }
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
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        data.count + 1
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
            
            return cell
        }
        //рисует ячейку постов
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.cellID,
            for: indexPath
        ) as? PostTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        
        cell.update(data[indexPath.row-1])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let  tableRow = indexPath.row
        if tableRow == 0 {
            let viewController = PhotosViewController()
            
            navigationController?.pushViewController(viewController, animated: true)
        }
        
    }

    
}

extension ProfileViewController: UITableViewDelegate {}


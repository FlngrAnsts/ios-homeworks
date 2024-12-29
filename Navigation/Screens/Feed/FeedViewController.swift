//
//  FeedViewController.swift
//  Navigation
//
//  Created by Anastasiya on 28.03.2024.
//

import UIKit
import StorageService

class FeedViewController: UITableViewController {
    // MARK: - Свойства
        var currentUser: UserData? 
        var postArray: [PostData] = []

        // MARK: - Жизненный цикл
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            
            self.tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.cellID)
            
            getUser()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            updateUI()
        }
        
        // MARK: - Получение данных пользователя
        func getUser() {
            currentUser = CoreDataManager.shared.fetchAuthorizedUser()
        }
        
        // MARK: - Обновление интерфейса
        func updateUI() {
            
            if let postsSet = currentUser?.posts as? Set<PostData>,
               let feedSet = currentUser?.feedPosts as? Set<PostData> {
                
                var array = Array(postsSet) + Array(feedSet)
                
                array.sort { (post1, post2) -> Bool in
                    if let date1 = post1.date, let date2 = post2.date {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd" // Формат даты
                        if let formattedDate1 = dateFormatter.date(from: date1),
                           let formattedDate2 = dateFormatter.date(from: date2) {
                            return formattedDate1 > formattedDate2
                        }
                    }
                    return false
                }
                
                postArray = array
                
                tableView.reloadData()
            } else {
                print("No posts found.")
            }
            
            tableView.reloadData()
        }
        
        // MARK: - Методы UITableViewDataSource
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            postArray.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PostTableViewCell.cellID,
                for: indexPath
            ) as? PostTableViewCell else {
                fatalError("Не удалось создать PostTableViewCell")
            }
            
            if let user = currentUser {
                cell.getUser(with: user)
            }
            cell.update(with: postArray[indexPath.row])
            
            return cell
        }
        
        // MARK: - Редактирование таблицы
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
    }

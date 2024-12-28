//
//  FeedViewController.swift
//  Navigation
//
//  Created by Anastasiya on 28.03.2024.
//

import UIKit
import StorageService

class FeedViewController: UITableViewController {
    
    var currentUser: UserData?
    var postArray: [PostData] = []
//    init(user: UserData) {
//        self.currentUser = user
//        super.init(nibName: nil, bundle: nil)
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
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
    func getUser(){
        currentUser = CoreDataManager.shared.fetchAuthorizedUser()
    }
    
    func updateUI() {
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
            postArray = postsArray
            
            tableView.reloadData()  // Assuming you have a tableView set up
        } else {
            print("No posts found.")
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.cellID,
            for: indexPath
        ) as? PostTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        let user = currentUser
        cell.getUser(with: user!)
        cell.update(postArray[indexPath.row])
        
        return cell
    }
    
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
 
    
}

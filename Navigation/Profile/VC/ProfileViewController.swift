//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Anastasiya on 28.03.2024.
//

import UIKit
import StorageService


class ProfileViewController: UIViewController {
    
    var user: User?
    
    var timer : Timer?
    var count = 10.0
    
   
    
    var viewModel: ProfileViewModel
    
    var coordinator: ProfileCoordinator?
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate var data = Post.make()
    
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
        bindViewModel()
        viewModel.changeStateIfNeeded()
          
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
//        
//        view.addGestureRecognizer(tapGesture)
        
    }
    
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        print("tapped")
        killTimer()
        
        timerTest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.beginAppearanceTransition(true, animated: true)
        self.endAppearanceTransition()
        
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        timerTest()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        killTimer()
    }
    
    func timerTest(){
        
        count = 10.0
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0,
                                     repeats: count == 0 ? false : true,
                                     block: { [weak self] timer in
            guard let self else {return}
            
                print (count)
                if count == 0 {
                    killTimer()
                    logOut()
                }
                count -= 1
        })
        
    }
    
    func logOut(){
            timer?.invalidate()
            let viewModel = LoginViewModel()
            let logInVC = LogInViewController(viewModel: viewModel, delegate: MyLoginFactory().makeLoginInspector())
            
            self.navigationController?.pushViewController(logInVC, animated: false)
    }
    
    func killTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    
    
    private func bindViewModel() {
        viewModel.currentState = { [weak self] state in
            guard let self else { return }
            switch state {
            case .initial:
                print("initial")
            case .loading:
                tableView.isHidden = true
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
            case .loaded(let post):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.data = post
                    tableView.isHidden = false
                    tableView.reloadData()
                    activityIndicator.isHidden = true
                    activityIndicator.stopAnimating()
                }
            case .error:
                print("error")
            }
            
        }
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


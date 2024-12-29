//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Anastasiya on 28.03.2024.
//

import UIKit
import CoreData


class ProfileViewController: UIViewController, ProfileSettingsDelegate, CreatePostDelegate  {
    // MARK: - Свойства
    var currentUser: UserData? // Текущий пользователь
    var routeToPhoto: (() -> ())? // Замыкание для перехода к фотографиям
    var routeToLogin: (() -> ())? // Замыкание для перехода к экрану авторизации
    private let profileHeaderView = ProfileHeaderView() // Хедер профиля
    var postDataArray: [PostData] = [] // Массив постов пользователя
    var photoArray: [PhotoData] = [] // Массив фотографий пользователя

    // Таблица для отображения постов и фотографий
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isUserInteractionEnabled = true
        return tableView
    }()

    // MARK: - Инициализация
    init(user: UserData) {
        self.currentUser = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been реализован")
    }

    // MARK: - Жизненный цикл
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
        tableView.reloadData()
    }

    // MARK: - Действия
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        print("Тапнули")
    }

    @objc private func logoutButtonTapped() {
        routeToLogin?()
    }

    // MARK: - Методы настройки интерфейса
    private func setupView() {
        view.backgroundColor = .customBackgroundColor
        navigationController?.navigationBar.isHidden = false
        // Кнопка выхода из профиля
        let logoutButton = UIBarButtonItem(
            image: UIImage(systemName: "person.crop.circle.fill.badge.xmark"),
            style: .done,
            target: self,
            action: #selector(logoutButtonTapped)
        )
        navigationItem.rightBarButtonItem = logoutButton
        logoutButton.tintColor = UIColor.customTextColor
        navigationItem.hidesBackButton = true
    }

    private func addSubviews() {
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }

    private func tuneTableView() {
        let headerView = profileHeaderView
        headerView.buttonSettingCallback = settingVC
        headerView.buttonPostCallback = createPostVC

        tableView.tableHeaderView = profileHeaderView
        tableView.setAndLayout(headerView: headerView)
        tableView.tableFooterView = UIView()

        // Регистрация ячеек
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

    // MARK: - Методы загрузки данных
    private func loadUserData() {
        profileHeaderView.setupProfile(user: currentUser!) 
    }

    func loadPosts() {
        guard let postsSet = currentUser?.posts as? Set<PostData> else {
            print("Посты не найдены.")
            return
        }

        // Сортировка постов по дате (от новых к старым)
        let postsArray = postsSet.sorted { post1, post2 in
            guard let date1 = post1.date, let date2 = post2.date else { return false }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let formattedDate1 = dateFormatter.date(from: date1),
               let formattedDate2 = dateFormatter.date(from: date2) {
                return formattedDate1 > formattedDate2
            }
            return false
        }

        postDataArray = postsArray
        tableView.reloadData()
    }

    private func fetchPhotosFromCoreData() {
        guard let photoSet = currentUser?.photos as? Set<PhotoData> else {
            print("Фотографии не найдены.")
            return
        }

        photoArray = Array(photoSet)
        tableView.reloadData()
    }

    // MARK: - Методы делегатов
    func didCreatePost(_ post: PostData) {
        postDataArray.insert(post, at: 0) // Добавление нового поста
        tableView.reloadData()
    }

    func didUpdateProfile(user: UserData) {
        currentUser = user
        profileHeaderView.setupProfile(user: user) // Обновление профиля
        tableView.reloadData()
    }

    func settingVC() {
        let viewController = SettingViewController()
        viewController.currentUser = currentUser
        viewController.delegate = self
        present(viewController, animated: true) // Переход к экрану настроек
    }

    func createPostVC() {
        let viewController = CreatePostViewController()
        viewController.currentUser = currentUser
        viewController.delegate = self
        present(viewController, animated: true) // Переход к экрану создания поста
    }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDataArray.count + 1 // Количество строк: фотографии + посты
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Первая ячейка: фотографии
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PhotosTableViewCell.cellID,
                for: indexPath
            ) as? PhotosTableViewCell else {
                fatalError("Не удалось создать PhotosTableViewCell")
            }
            cell.create(with: photoArray)
            cell.buttonTapCallback = routeToPhoto
            return cell
        }

        // Остальные ячейки: посты
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.cellID,
            for: indexPath
        ) as? PostTableViewCell else {
            fatalError("Не удалось создать PostTableViewCell")
        }

        if let user = currentUser {
            cell.getUser(with: user) // Установка пользователя
        }

        let post = postDataArray[indexPath.row - 1]
        cell.update(with: post) // Установка данных поста
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            let postToDelete = postDataArray[indexPath.row - 1] // Пост для удаления
            postDataArray.remove(at: indexPath.row - 1) // Удаление из массива
            CoreDataManager.shared.deletePost(by: postToDelete) // Удаление из Core Data
            tableView.deleteRows(at: [indexPath], with: .automatic) // Обновление таблицы
        }
    }
}


//
//  InfoViewController.swift
//  Navigation
//
//  Created by Anastasiya on 28.03.2024.
//

import UIKit

class InfoViewController: UIViewController {
    
    var coordinator: FeedCoordinator?
    var residentsPlanet : [ResidentPlanet] = []
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.backgroundColor = .white
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.black.cgColor
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var planetNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.black.cgColor
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var planetLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.black.cgColor
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .plain
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var actionButton: CustomButton = {
        
        let button = CustomButton(title: "Button", titleColor: .white){
            self.buttonPressed()
        }
        button.layer.cornerRadius = 10
        
        button.setBackgroundImage(UIImage(named: "ButtonColor"), for: .normal)
        
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        
        addSubviews()
        
        setupContraints()
        tuneTableView()
        getTitle()
        getPlanet()
        
        
    }
    
    private func addSubviews(){
        view.addSubview(actionButton)
        view.addSubview(titleLabel)
        view.addSubview(planetLabel)
        view.addSubview(planetNameLabel)
        view.addSubview(tableView)
    }
    
    private func setupContraints(){
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            actionButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20.0
            ),
            actionButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20.0
            ),
            actionButton.heightAnchor.constraint(equalToConstant: 40),
            actionButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            planetNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            planetNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            planetNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            planetNameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            planetLabel.topAnchor.constraint(equalTo: planetNameLabel.bottomAnchor),
            planetLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            planetLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            planetLabel.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: planetLabel.bottomAnchor, constant: 40),
            tableView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            tableView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            ),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
        ])
    }
    
    func buttonPressed() {
        let alert = UIAlertController(title: "Вы принесли полотенце?", message: "Лучше возьмите с собой полотенце.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { action in
            print("Вы молодец!")
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: { action in
            print("Ничего страшного")
        }))
        
        self.present(alert, animated: true)
        
    }
    
    func getTitle(){
        NetworkManager.getTitle { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let title):
                    self?.titleLabel.text = title
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getPlanet(){
        NetworkManager.getPlanet { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let planet):
                    self?.planetNameLabel.text = planet.name
                    self?.planetLabel.text = planet.orbitalPeriod
                    self?.getResidentsPlanet(planet: planet)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func tuneTableView() {
        
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.cellId)
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func getResidentsPlanet(planet: Planet){
        
        NetworkManager.getResidentsPlanet(planet: planet){ result in
            switch result{
                
            case .success(let residents):
                DispatchQueue.main.async {
                    self.residentsPlanet = residents
                    self.tableView.reloadData()
                }
            case .failure(_):
                break
            }
            
        }
    }
    
}

extension InfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residentsPlanet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: InfoTableViewCell.cellId,
            for: indexPath
        ) as? InfoTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        cell.update(residentsPlanet[indexPath.row])
        
        return cell
    }
    
}

extension InfoViewController: UITableViewDelegate {}

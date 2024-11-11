//
//  FeedViewController.swift
//  Navigation
//
//  Created by Anastasiya on 28.03.2024.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {
    
    let feedModel = FeedModel()
    var coordinator: FeedCoordinator?
    
    private lazy var mapButton: CustomButton = {
        
        let button = CustomButton(title: "Карта", titleColor: .systemBlue){
            self.mapButtonPressed()
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
        
    }()
    
    private lazy var actionButton: CustomButton = {
        
        let button = CustomButton(title: "Перейти", titleColor: .systemBlue){
            self.buttonPressed()
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
        
    }()
    
    private lazy var checkGuessTextView: UITextField = {//[unowned self] in
        let textView = UITextField()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.backgroundColor = .lightGray
        textView.borderStyle = UITextField.BorderStyle.roundedRect
        textView.autocorrectionType = UITextAutocorrectionType.no
        
        return textView
    }()
    
    private lazy var checkGuessButton: CustomButton = {
        let button = CustomButton(title: "Check Guess", titleColor: .black){
            if(self.checkGuessTextView.text != nil && self.feedModel.check(word: self.checkGuessTextView.text!)){
                
                self.checkGuessLabel.backgroundColor = .green
                self.checkGuessLabel.text = "correctly"
                
            }else{
                self.checkGuessLabel.backgroundColor = .red
                self.checkGuessLabel.text = "failed"
            }
        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var checkGuessLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var stackView: UIStackView = { [unowned self] in
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.spacing = 10.0
            stackView.addArrangedSubview(self.actionButton)
            
            
            stackView.addArrangedSubview(self.checkGuessTextView)
            stackView.addArrangedSubview(self.checkGuessButton)
            stackView.addArrangedSubview(self.checkGuessLabel)
        
            return stackView
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray4
        
        view.addSubview(stackView)
        view.addSubview(mapButton)
        setupContraints()
        
    }
    
    func setupContraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            mapButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24),
            mapButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    
     func buttonPressed() {
        let postViewController = PostViewController()
        
        self.navigationController?.pushViewController(postViewController, animated: true)
        
        postViewController.titlePost = Post.make()[0].author
    }
    
    func mapButtonPressed() {
       let mapViewController = MapViewController()
       
       self.navigationController?.pushViewController(mapViewController, animated: true)
       
   }
}

//
//  PlanetDetailViewController.swift
//  SyscoTest
//
//  Created by ADL on 2022-06-06.
//

import UIKit

class PlanetDetailViewController: UIViewController {
    var plantsDetails: PlanetsApiResultsModel?

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("back", for: .normal)
        button.addTarget(self, action: #selector(BackbuttonTapped), for: .touchUpInside)
        button.backgroundColor = .gray
        return button
    }()
    
    lazy var gravityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var orbitoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        if plantsDetails != nil{
            nameLabel.text = plantsDetails?.name
            orbitoryLabel.text = plantsDetails?.orbital_period
            gravityLabel.text = plantsDetails?.gravity
        }
    }
    // MARK: Custom Method
    func setup() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(backButton)
        self.view.addSubview(gravityLabel)
        self.view.addSubview(orbitoryLabel)
        self.view.addSubview(nameLabel)
        
        orbitoryLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor,constant: 0).isActive = true
        orbitoryLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: 0).isActive = true
        
        gravityLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor,constant: 0).isActive = true
        gravityLabel.topAnchor.constraint(equalTo: orbitoryLabel.bottomAnchor, constant: 10).isActive = true
        
        nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor,constant: 0).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: orbitoryLabel.topAnchor, constant: -10).isActive = true
        
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
    }
    
    @objc func BackbuttonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

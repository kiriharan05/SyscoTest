//
//  PlanetDetailViewController.swift
//  SyscoTest
//
//  Created by ADL on 2022-06-06.
//

import UIKit

class PlanetDetailViewController: UIViewController {
    var plantsDetails: PlanetsApiResultsModel?
    
    lazy var gravityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    lazy var orbitoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    lazy var holderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.0
        view.clipsToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        if plantsDetails != nil{
            nameLabel.text = "Planet Name: " + (plantsDetails?.name)!
            orbitoryLabel.text = "Orbital Period: " + (plantsDetails?.orbital_period)!
            gravityLabel.text = "Gravity: " + (plantsDetails?.gravity)!
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view != self.holderView
        { self.dismiss(animated: true, completion: nil) }
    }
    
    // MARK: Custom Method
    func setup() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        self.view.addSubview(holderView)
        self.holderView.addSubview(gravityLabel)
        self.holderView.addSubview(orbitoryLabel)
        self.holderView.addSubview(nameLabel)
        
        holderView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        holderView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        holderView.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.6).isActive = true
        holderView.heightAnchor.constraint(equalTo: holderView.widthAnchor,multiplier: 1.0).isActive = true
        
        
        orbitoryLabel.centerXAnchor.constraint(equalTo: self.holderView.centerXAnchor,constant: 0).isActive = true
        orbitoryLabel.centerYAnchor.constraint(equalTo: self.holderView.centerYAnchor,constant: 0).isActive = true
        
        gravityLabel.centerXAnchor.constraint(equalTo: self.holderView.centerXAnchor,constant: 0).isActive = true
        gravityLabel.topAnchor.constraint(equalTo: orbitoryLabel.bottomAnchor, constant: 10).isActive = true
        
        nameLabel.centerXAnchor.constraint(equalTo: self.holderView.centerXAnchor,constant: 0).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: orbitoryLabel.topAnchor, constant: -10).isActive = true
    }
    
    @objc func BackbuttonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

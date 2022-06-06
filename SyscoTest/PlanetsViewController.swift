//
//  PlanetsViewController.swift
//  SyscoTest
//
//  Created by ADL on 2022-06-06.
//

import UIKit
import SDWebImage

class PlanetsViewController: UIViewController {
    var planetsApiData: PlanetsApiModel?
    var dataArray: [PlanetsApiResultsModel]? = []
    var cellId = "PlanetTableViewCell"
    var cellLoadingId = "LoadingTableViewCell"
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    // MARK: Custom Method
    func setup() {
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        tableView.register(PlanetsTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: cellLoadingId)
        loadMoreData()
    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            DispatchQueue.global().async {
                if self.planetsApiData?.next != nil{
                    Services().getNextPlanetData(path: (self.planetsApiData?.next)!) { planetData in
                        self.planetsApiData = planetData
                        DispatchQueue.main.async {
                            self.dataArray?.append(contentsOf: (self.planetsApiData?.results)!)
                            self.tableView.reloadData()
                            self.isLoading = false
                        }
                    } faliure: { error in
                        self.isLoading = false
                    }
                }else{
                    Services().getPlanetData { planetData in
                        self.planetsApiData = planetData
                        DispatchQueue.main.async {
                            self.dataArray?.append(contentsOf: (self.planetsApiData?.results)!)
                            self.tableView.reloadData()
                            self.isLoading = false
                        }
                    } faliure: { error in
                        self.isLoading = false
                    }
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
            loadMoreData()
        }
    }
}

// MARK: UITableViewDataSource,UITableViewDelegate
extension PlanetsViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.dataArray!.count
        } else if section == 1 {
            // loading cell
            return 1
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PlanetsTableViewCell
            let data = dataArray![indexPath.row]
            cell.nameLabel.text = data.name
            cell.climateLabel.text = data.climate
            let fileUrl = URL(string:"https://picsum.photos/200")
            cell.iconImageView.sd_setImage(with: fileUrl, completed: nil)
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellLoadingId, for: indexPath) as! LoadingTableViewCell
            if self.isLoading {
                cell.activityIndicator.startAnimating()
            } else {
                cell.activityIndicator.stopAnimating()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else {
            return 55 
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PlanetDetailViewController()
        vc.modalPresentationStyle = .fullScreen
        let data = dataArray![indexPath.row]
        vc.plantsDetails = data
        self.present(vc, animated: true, completion: nil)
    }
}

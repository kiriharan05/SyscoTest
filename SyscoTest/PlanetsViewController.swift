//
//  NewPlanetsViewController.swift
//  SyscoTest
//
//  Created by ADL on 2022-11-09.
//

import UIKit

class PlanetsViewController: UIViewController {
    var cellId = "PlanetTableViewCell"
    var isFetching = false
    var planetsApiResultsModel = [PlanetsApiResultsModel]()
    var planetsApiData: PlanetsApiModel?
    var currentSize = 0

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
        getChannelData()
    }

    //MARK: - getData from Web Service
    func getChannelData() {
        guard InternetConnectivity.isConnectedToNetwork() == true else {
            //End Refreshing and pop up noInternet Alert
            self.isFetching = false
            self.noInternetAlert()
            return
        }
        if !self.isFetching {
            self.isFetching = true
            if self.planetsApiData?.next != nil {
                fetchData(nextPath: (self.planetsApiData?.next)!)
            } else {
                fetchData(nextPath: nil)
            }
        }
    }

    func fetchData(nextPath : String?) {
        DispatchQueue.global().async {
            Services().getNextPlanetData(path: nextPath) { planetData in
                self.planetsApiData = planetData
                DispatchQueue.main.async {
                    self.planetsApiResultsModel.append(contentsOf: (self.planetsApiData?.results)!)
                    self.refreshViewByInsertingRows()
                    self.isFetching = false
                }
            } faliure: { error in
                self.isFetching = false
                self.errorAlert("Couldn't Find Data", error?.localizedDescription ?? "")
            }
        }
    }

    //MARK: - refreshViewByInsertingRows
    func refreshViewByInsertingRows(){
        if self.planetsApiResultsModel.count >= 1 {
            let indexPaths = (self.currentSize ..< self.planetsApiResultsModel.count).map { IndexPath(row: $0, section: 0) }
            print(indexPaths)
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: indexPaths, with: .bottom)
            self.tableView.endUpdates()
        }
        else{
            self.tableView.reloadData()
        }
    }

    //MARK: - Implementation of Api call for infinite scrolling
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contenHeight = scrollView.contentSize.height
        if offSetY > contenHeight - scrollView.frame.height * 1{
            if self.planetsApiData?.next != nil {
                currentSize = planetsApiResultsModel.count
                getChannelData()

            }
        }
    }

}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension PlanetsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetsApiResultsModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PlanetsTableViewCell
        let model : PlanetViewModel = PlanetViewModel(planetsApiResultsModel[indexPath.row], count: self.planetsApiData?.count, next: self.planetsApiData?.next, previous: self.planetsApiData?.previous)
        cell.item = model
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PlanetDetailViewController()
        let data = planetsApiResultsModel[indexPath.row]
        vc.plantsDetails = data
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity,0, 50, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.45) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else {
            return 55
        }
    }
}

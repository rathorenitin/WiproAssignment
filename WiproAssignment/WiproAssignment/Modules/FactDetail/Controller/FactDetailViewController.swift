//
//  FactDetailViewController.swift
//  WiproAssignment
//
//  Created by Apple on 22/12/19.
//  Copyright © 2019 Nitin Singh Rathore. All rights reserved.
//

import UIKit

class FactDetailViewController: UIViewController {
    
    //MARK:- @IBOutlets
//    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Public Properties
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tintColor = UIColor.black.withAlphaComponent(0.3)
        tableView.separatorStyle = .none
        tableView.register(FactDetailPortraitTableViewCell.self, forCellReuseIdentifier: "\(FactDetailPortraitTableViewCell.self)")
        tableView.register(FactDetailLandscapeTableViewCell.self, forCellReuseIdentifier: "\(FactDetailLandscapeTableViewCell.self)")
        return tableView
    }()
    
    let viewModel = ContactDetailsViewModel()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.reloadTableView()
    }
    
}

//MARK:- Extension for Private Methods
extension FactDetailViewController {
    
    //MARK:- Setting up initial views
    private func initialSetup() {
        
        setupNavigationView()
        setupTableview()
        prepareViewModelObserver()
        
    }
    
    private func setupNavigationView() {
        navigationItem.title = self.viewModel.FactDetails?.title ?? ""
    }
    
    //MARK:- Setting up Tableviews
    private func setupTableview() {
        self.view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
}

//MARK:- API Call action and obsevers
extension FactDetailViewController {
    
    func getContactDetails() {
        
        reloadTableView()
    }
    
    func prepareViewModelObserver() {
        
        self.viewModel.FactDetailChanges = { (finished, error) in
            
            if !error {
                self.reloadTableView()
            }
        }
        
    }
    
    func reloadTableView() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

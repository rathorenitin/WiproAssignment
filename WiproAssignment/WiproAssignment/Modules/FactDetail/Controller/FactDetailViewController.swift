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
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Public Properties
    let viewModel = ContactDetailsViewModel()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
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
        
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.3599199653, green: 0.9019572735, blue: 0.804747045, alpha: 1)
        navigationItem.title = self.viewModel.FactDetails?.title ?? ""
    }
    
    //MARK:- Setting up Tableviews
    private func setupTableview() {
        
        tableView.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tintColor = UIColor.black.withAlphaComponent(0.3)
        tableView.registerCell(with: FactDetailPortraitTableViewCell.self)
        tableView.registerCell(with: FactDetailLandscapeTableViewCell.self)
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

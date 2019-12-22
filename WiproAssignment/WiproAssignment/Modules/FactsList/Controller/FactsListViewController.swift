//
//  FactsListViewController.swift
//  WiproAssignment
//
//  Created by Apple on 22/12/19.
//  Copyright © 2019 Nitin Singh Rathore. All rights reserved.
//

import UIKit

class FactsListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var wayToUpdate: UICollectionView.WayToUpdate = .None
    let viewModel = FactsListViewModel()
    private var refreshController = UIRefreshControl()
    var numberOfColumns = 2
    var sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    var collectionViewSize : CGSize {
        get {
            let minimumInterItemSpacing: CGFloat = 10
            let side = (collectionView.frame.width - sectionInsets.left - sectionInsets.right - CGFloat(numberOfColumns - 1)*minimumInterItemSpacing - 0.002) / CGFloat(numberOfColumns)
            
            return CGSize.init(width: side, height: side)
        }
    }
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.initialSetup()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func initialSetup() {
        
        self.setupTableview()
        self.fetchContacts()
        self.setupNavigationView()
        self.setupRefreshController()
        self.prepareViewModelObserver()
    }
    
    private func setupTableview() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        collectionView.tintColor = UIColor.black.withAlphaComponent(0.3)
        collectionView.registerCell(with: FactCollectionViewCell.self)
    
    }
    
    private func setupRefreshController() {
        
        refreshController.tintColor = #colorLiteral(red: 0.3599199653, green: 0.9019572735, blue: 0.804747045, alpha: 1)
        refreshController.addTarget(self,
                                    action: #selector(pullToRefreshData),
                                    for: UIControl.Event.valueChanged)
        collectionView.refreshControl = refreshController
    }
    
    //MARK:- Action Methods
    @objc func pullToRefreshData() {
        
        self.fetchContacts()
    }
    
    //MARK:- Setting up navigationView
    private func setupNavigationView() {
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.title = "Facts"
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.3599199653, green: 0.9019572735, blue: 0.804747045, alpha: 1)
    }
}


//MARK:- API Call action and obsevers
extension FactsListViewController {
    
    func fetchContacts() {
        
        viewModel.fetchFactsList()
    }
    
    func prepareViewModelObserver() {
        
        self.viewModel.contactDidChanges = { (finished, error) in
            if !error {
                self.reloadTableView()
            }
        }
    }
    
    func reloadTableView() {
        
        DispatchQueue.main.async {
            self.refreshController.endRefreshing()
            self.wayToUpdate = .ReloadData
            self.wayToUpdate.performWithCollectionView(collectionView: self.collectionView)
        }
    }
    
    
}

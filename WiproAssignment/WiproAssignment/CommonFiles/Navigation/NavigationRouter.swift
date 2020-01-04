//
//  NavigationRouter.swift
//  WiproAssignment
//
//  Created by Apple on 22/12/19.
//  Copyright © 2019 Nitin Singh Rathore. All rights reserved.
//

import UIKit

class NavigationRouter {
    
    static let shared  = NavigationRouter()
    var navigationController = UINavigationController()

    private init() {
        
    }

    func initialViewController(window: UIWindow?) {
        
        let factsListViewController = FactsListViewController()
        navigationController = UINavigationController(rootViewController: factsListViewController)
        window?.rootViewController = navigationController
    }
    
    func navigateToFactDetailsViewController(fact: FactModel)-> FactDetailViewController {
        let factDetailViewController = FactDetailViewController()
        factDetailViewController.viewModel.FactDetails = fact
        navigationController.pushViewController(factDetailViewController, animated: true)
        return factDetailViewController
    }
    
    func popViewController() {
        self.navigationController.popViewController(animated: true)
    }
    
    func dismissViewController() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
    
}

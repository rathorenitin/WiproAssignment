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
        
        let factsListViewController = FactsListViewController.instantiate()
        navigationController = UINavigationController(rootViewController: factsListViewController)
        window?.rootViewController = navigationController
    }
    
    func popViewController() {
        self.navigationController.popViewController(animated: true)
    }
    
    func dismissViewController() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
    
}

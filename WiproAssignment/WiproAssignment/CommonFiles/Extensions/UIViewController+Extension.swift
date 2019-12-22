//
//  UIViewController+Extension.swift
//  WiproAssignment
//
//  Created by Apple on 22/12/19.
//  Copyright © 2019 Nitin Singh Rathore. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func instantiate() -> Self {
        
        return UIStoryboard.instance.viewController(self)
    }
    
    func initialViewController() -> UIViewController? {
        
        return UIStoryboard.instance.instantiateInitialViewController()
    }
}

extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
        
    }
}

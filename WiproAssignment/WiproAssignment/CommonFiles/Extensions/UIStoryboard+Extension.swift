//
//  UIStoryboard+Extension.swift
//  WiproAssignment
//
//  Created by Apple on 22/12/19.
//  Copyright © 2019 Nitin Singh Rathore. All rights reserved.
//

import UIKit

//MARK:- This is used to instantiate the storyboard and returns it

extension UIStoryboard {
    
    private static var storyboardName : String {
        return "Main"
    }
    
    static var instance : UIStoryboard {
        
        return UIStoryboard(name: storyboardName, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(_ viewControllerClass : T.Type,
                                              function : String = #function, // debugging purposes
        line : Int = #line,
        file : String = #file) -> T {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = UIStoryboard.instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            
            fatalError("ViewController with identifier \(storyboardID), not found in \(UIStoryboard.storyboardName) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
    
}


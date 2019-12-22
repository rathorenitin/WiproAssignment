//
//  UICollectionView+Extension.swift
//  WiproAssignment
//
//  Created by Apple on 22/12/19.
//  Copyright © 2019 Nitin Singh Rathore. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    enum WayToUpdate {
        
        case None
        case ReloadData
        case Insert([IndexPath])
        case ReloadItems([IndexPath])
        case ReloadSections(IndexSet)
      
        
        func performWithCollectionView(collectionView: UICollectionView) {
            
            switch self {
                
            case .None:
                break
                
            case .ReloadData:
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
                
            case .Insert(let indexPaths):
                DispatchQueue.main.async {
                    collectionView.insertItems(at: indexPaths)
                }
            case .ReloadItems(let indexPaths):
                DispatchQueue.main.async {
                    collectionView.reloadItems(at: indexPaths)
                }

            case .ReloadSections(let indexSet):
                DispatchQueue.main.async {
                    collectionView.reloadSections(indexSet)
                }

            }
        }
    }
    
    func registerCell(with identifier: UICollectionViewCell.Type) {
        self.register(UINib(nibName: "\(identifier.self)",bundle:nil),
                      forCellWithReuseIdentifier: "\(identifier.self)")
    }
}


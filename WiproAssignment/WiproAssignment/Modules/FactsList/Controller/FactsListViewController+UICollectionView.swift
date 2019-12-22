//
//  FactsListViewController+UICollectionView.swift
//  WiproAssignment
//
//  Created by Apple on 22/12/19.
//  Copyright © 2019 Nitin Singh Rathore. All rights reserved.
//

import UIKit

// MARK: Collection View DataSources
extension FactsListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  viewModel.getFactPhotoModelCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FactCollectionViewCell.self)", for: indexPath) as? FactCollectionViewCell else {
            fatalError("FactCollectionViewCell crashed at \(indexPath)")
        }
        cell.factValue = viewModel.getFactPhotoModel(withIndex: indexPath.item)
        return cell
    }
}

// MARK: Collection View Delegates
extension FactsListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = viewModel.getFactPhotoModel(withIndex: indexPath.item){
            let _ = NavigationRouter.shared.navigateToFactDetailsViewController(fact: model)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let factImage = viewModel.getFactPhotoModel(withIndex: indexPath.item)  else {
            return
        }
        
        if factImage.isDownloading {
            return
        }
        
        ImageDownloader.shared.downloadImage(at: indexPath, image: factImage, completion: { [weak self] (indexPath, image, error) in
            
            DispatchQueue.main.async { [weak self] in
                
                guard let strongSelf = self else {
                    return
                }
                guard let index = indexPath else {
                    return
                }
                
                if  !factImage.isDownloaded {
                    
                    strongSelf.viewModel.setUpFactImageDataOnDownloadCompletion(withThumbImage : image,withIndex : index.item)
                    
                    strongSelf.wayToUpdate = .ReloadItems([index])
                    strongSelf.wayToUpdate.performWithCollectionView(collectionView: strongSelf.collectionView)
                    
                }
                
            }
        })
        
        cell.contentView.alpha = 0.3
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        
        UIView.animate(withDuration: 0.5) {
            cell.contentView.alpha = 1
            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        viewModel.setDownloadTaskPriority(withType: .low, withIndex: indexPath.item)
    }
    
    
}

extension FactsListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  collectionViewSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}


extension FactsListViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidEndDecelerating(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        increaseDownloadPriorityOfVisibleCells()
    }
    
    // Increase priority of download task for visible cells
    func increaseDownloadPriorityOfVisibleCells() {
        
        collectionView.visibleCells.forEach { cell in
            if let indexPath = collectionView.indexPath(for: cell) {
                viewModel.setDownloadTaskPriority(withType: .high, withIndex: indexPath.item)
            }
        }
    }
}

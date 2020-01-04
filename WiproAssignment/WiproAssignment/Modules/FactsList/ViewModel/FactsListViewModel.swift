//
//  FactsListViewModel.swift
//  WiproAssignment
//
//  Created by Apple on 22/12/19.
//  Copyright © 2019 Nitin Singh Rathore. All rights reserved.
//

import UIKit

protocol FactsListViewModelProtocol {
    
    func fetchFactsList()
}

class FactsListViewModel: FactsListViewModelProtocol {
    
    enum DownloadPriority {
        
        case low
        case high
        
    }
    
    var contactDidChanges: ((Bool, Bool) -> Void)?
    var errorOccured: ((String) -> Void)?
    let networkService: NetworkServiceProtocol = NetworkService()
    private var factList = [FactModel]() {
        didSet {
            self.contactDidChanges?(true, false)
        }
    }
    
    init() {
        factList = [FactModel]()
    }
    
    func fetchFactsList() {
        networkService.webRequest(.getFactsList, { [weak self] response in
            
            guard let strongSelf = self else {return}
            
            let utf8Data = String(decoding: response, as: UTF8.self).data(using: .utf8)
            let feedModel = try? JSONDecoder().decode(FeedsModel.self, from: utf8Data ?? response)
            if let facts = feedModel?.rows {
                strongSelf.factList = facts
            } else {
                print("Unable to decode json for facts list.")
                strongSelf.errorOccured?("Unable to decode json for facts list.")
            }
        }) { [weak self] error in
            
            guard let strongSelf = self else {return}
            
            print("Error : \(error)")
            strongSelf.errorOccured?(error.localizedDescription)
        }
    }
    
    func setUpFactImageDataOnDownloadCompletion(withThumbImage : UIImage?,withIndex : Int) {
        
        if let image  = getFactPhotoModel(withIndex : withIndex) {
            image.thumbNailImage = withThumbImage
            image.isDownloaded = true
        }
        
    }
    
    func getFactPhotoModel(withIndex : Int)  -> FactModel? {
        
        if factList.indices.contains(withIndex) {
            return factList[withIndex]
        }
        
        return nil
    }
    
    func getFactPhotoModelCount() -> Int {
        return factList.count
    }
    
    func setDownloadTaskPriority(withType :DownloadPriority,withIndex : Int) {
        
        switch withType {
        case .low:
            if let image  = getFactPhotoModel(withIndex : withIndex) {
                image.downloadTask?.priority = URLSessionDataTask.lowPriority
            }
        case .high:
            if let image  = getFactPhotoModel(withIndex : withIndex) {
                image.downloadTask?.priority = URLSessionDataTask.highPriority
            }
        }
    }
}

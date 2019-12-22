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
        networkService.webRequest(.getFactsList, { response in
            let utf8Data = String(decoding: response, as: UTF8.self).data(using: .utf8)
            let feedModel = try! JSONDecoder().decode(FeedsModel.self, from: utf8Data ?? response)
            if let facts = feedModel.rows {
                self.factList = facts
            } else {
                print("Unable to decode json for facts list.")
            }
        }) { error in
            print("Error : \(error)")
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

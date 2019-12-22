//
//  FactsListViewModel.swift
//  WiproAssignment
//
//  Created by Apple on 22/12/19.
//  Copyright © 2019 Nitin Singh Rathore. All rights reserved.
//

import Foundation
protocol FactsListViewModelProtocol {
    
    func fetchFactsList()
}

class FactsListViewModel: FactsListViewModelProtocol {
    
    var contactDidChanges: ((Bool, Bool) -> Void)?
    let networkService: NetworkServiceProtocol = NetworkService()
    var factList: [FactModel]? {
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
                print(facts)
            } else {
                print("Unable to decode json for facts list.")
            }
        }) { error in
            print("Error : \(error)")
        }
    }
    
}

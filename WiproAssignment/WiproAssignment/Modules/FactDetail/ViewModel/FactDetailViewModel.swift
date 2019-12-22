//
//  FactDetailViewModel.swift
//  WiproAssignment
//
//  Created by Apple on 22/12/19.
//  Copyright © 2019 Nitin Singh Rathore. All rights reserved.
//

import Foundation
protocol FactDetailViewModelProtocol {
    
}

class ContactDetailsViewModel: FactDetailViewModelProtocol {

    var FactDetailChanges: ((Bool, Bool) -> Void)?
    var FactDetails: FactModel? {
        didSet {
            self.FactDetailChanges?(true, false)
        }
    }
    
    let networkService: NetworkServiceProtocol = NetworkService()

    init() {
    }
    
}



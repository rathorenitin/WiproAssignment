//
//  FactModel.swift
//  WiproAssignment
//
//  Created by Apple on 22/12/19.
//  Copyright © 2019 Nitin Singh Rathore. All rights reserved.
//

import Foundation

struct FeedsModel: Codable {
    let title: String?
    let rows: [FactModel]?
}


struct FactModel: Codable {
    
    let title: String?
    let description: String?
    let imageHref: String?

    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageHref
    }
}



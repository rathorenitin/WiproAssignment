//
//  FactModel.swift
//  WiproAssignment
//
//  Created by Apple on 22/12/19.
//  Copyright © 2019 Nitin Singh Rathore. All rights reserved.
//

import UIKit

struct FeedsModel: Codable {
    let title: String?
    let rows: [FactModel]?
}


class FactModel: Codable {
    
    let title: String?
    let description: String?
    let imageHref: String?
    var isDownloading: Bool = false
    var isDownloaded: Bool = false
    var downloadTask: URLSessionDataTask?
    var thumbNailImage : UIImage?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageHref
    }
}



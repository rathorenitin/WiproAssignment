//
//  FactsRouter.swift
//  WiproAssignment
//
//  Created by Apple on 22/12/19.
//  Copyright © 2019 Nitin Singh Rathore. All rights reserved.
//

import Foundation

enum FactsRouter {
    
    case getFactsList


    var baseURL: String {
        
        return "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/"
    }
    
    var getURL: URL {
        
        switch self {
        case .getFactsList:
            return URL(string: "\(baseURL)facts.json")!
        }
    }
    
    var getRequestParameter: [String:AnyObject] {
        
        switch self {
        case .getFactsList:
            return [:]
        }
    }
    
    var getHTTPMethod: String {
        
        switch self {
        case .getFactsList:
            return "GET"
        }
    }
    
}

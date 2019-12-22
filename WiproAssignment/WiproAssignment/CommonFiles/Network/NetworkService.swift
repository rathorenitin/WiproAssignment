//
//  NetworkService.swift
//  WiproAssignment
//
//  Created by Apple on 22/12/19.
//  Copyright © 2019 Nitin Singh Rathore. All rights reserved.
//

import Foundation

//MARK:- NetworkService Protocol to hit a service
protocol NetworkServiceProtocol {
    
    func webRequest(_ endPoint: FactsRouter, _ success: @escaping(Data) -> Void, _ failure: @escaping(Error) -> Void)
}

//MARK:- NetworkService class to hit web services
class NetworkService: NetworkServiceProtocol {
    
    func webRequest(_ endPoint: FactsRouter, _ success: @escaping (Data) -> Void, _ failure: @escaping (Error) -> Void) {
                
        let request = NSMutableURLRequest(url: endPoint.getURL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = endPoint.getHTTPMethod
        
        let headers = ["Content-Type": "application/json"]
        request.allHTTPHeaderFields = headers
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: request as URLRequest,
                                        completionHandler: { (data, response, error) -> Void in
                                            if error != nil, let error = error {
                                                failure(error)
                                            } else if let data = data {
                                                success(data)
                                            }
        })
        dataTask.resume()
    }
}

//
//  ImageDownloader.swift
//  WiproAssignment
//
//  Created by Apple on 22/12/19.
//  Copyright © 2019 Nitin Singh Rathore. All rights reserved.
//

import UIKit

class ImageDownloader {
    
    static let shared = ImageDownloader()
    let imageCache = NSCache<NSString, UIImage>()
    
    func downloadImage(at indexPath: IndexPath? = nil, image: FactModel, completion: @escaping (IndexPath?, UIImage?, Error?) -> Void) {
        
        if let cachedImage = imageCache.object(forKey: (image.imageHref ?? "") as NSString) {
            completion(indexPath, cachedImage, nil)
            
        } else {
            downloadDataForImage(image, completion: { (image, error) in
                completion(indexPath, image, error)
            })
        }
    }
    
    private func downloadDataForImage(_ image: FactModel, completion: @escaping ((UIImage, Error?) -> ())) {
        
        guard let url = URL(string: image.imageHref ?? "") else {return}
        image.isDownloading = true
        
        
        let downloadTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            image.isDownloading = false
            image.downloadTask = nil
            
            if let _ = error {
                return
            }
            
            if data != nil {
                
                if let downloadedImage = UIImage(data: data!) {
                    self.imageCache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
                    completion(downloadedImage, nil)
                    
                }
            }
        })
        
        downloadTask.priority = URLSessionDataTask.lowPriority
        image.downloadTask = downloadTask
        downloadTask.resume()
    }
}

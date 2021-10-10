//
//  APIService.swift
//  CachingImages
//
//  Created by xcismans on 08/10/2021.
//

import UIKit

class APIService: NSObject {
    
    private let sourcesURL = URL(string: "https://picsum.photos/v2/list?page=1&limit=30")!
    
    func apiToGetPhotosData(completion : @escaping ([PhotosData]) -> ()){
        
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let photosData = try! jsonDecoder.decode([PhotosData].self, from: data)
            
                    completion(photosData)
            }
            
        }.resume()
    }
}

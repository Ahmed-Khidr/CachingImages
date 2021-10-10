//
//  PhotosViewModel.swift
//  CachingImages
//
//  Created by xcismans on 08/10/2021.
//

import UIKit

class PhotosViewModel: NSObject {
    
    weak var dataSource : GenericDataSource<PhotosData>?
    private var apiService : APIService!
    
    init(dataSource : GenericDataSource<PhotosData>?) {
        super.init()
        self.dataSource = dataSource
        self.apiService =  APIService()
    }
    
    func callFuncToGetPhotosData(pageNum: String) {
        self.apiService.apiToGetPhotosData(pageNum: pageNum) { (photosResponse) in
            self.dataSource?.data.value = photosResponse
            self.addAdvertisingToPhotos()
        }
    }
    func addAdvertisingToPhotos(){
        if self.dataSource?.data.value.count ?? 0 > 5{
            let numberOfWholePhotos = self.dataSource?.data.value.count
            var incremental = 0
            for i in 1...numberOfWholePhotos!{
                if ((i) % 5) == 0{
                    let ad = PhotosData(id: "AdsImage", author: "", width: 0, height: 0, url: "", download_url: "")
                    self.dataSource?.data.value.insert(ad, at: i + incremental)
                    incremental += 1
                }
            }
        }
        
    }
}



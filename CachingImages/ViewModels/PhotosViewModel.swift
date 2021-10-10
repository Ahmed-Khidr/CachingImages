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
    private(set) var photosData : [PhotosData]! {
        didSet {
            self.bindPhotosViewModelToController()
        }
    }
    
    var bindPhotosViewModelToController : (() -> ()) = {}
    
    init(dataSource : GenericDataSource<PhotosData>?) {
        super.init()
        self.dataSource = dataSource
        self.apiService =  APIService()
        callFuncToGetPhotosData()
    }
    
    func callFuncToGetPhotosData() {
        self.apiService.apiToGetPhotosData { (photosResponse) in
            //self.photosData = photosResponse
            self.dataSource?.data.value = photosResponse
        }
    }
}

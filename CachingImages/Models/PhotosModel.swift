//
//  PhotosModel.swift
//  CachingImages
//
//  Created by xcismans on 08/10/2021.
//

import Foundation

struct PhotosModel: Decodable{
    var photosData: [PhotosData]
}

struct PhotosData: Decodable{
    let id : String?
    let author : String?
    let width : Int?
    let height : Int?
    let url : String?
    let download_url : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case author = "author"
        case width = "width"
        case height = "height"
        case url = "url"
        case download_url = "download_url"
    }
}

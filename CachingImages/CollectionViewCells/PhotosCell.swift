//
//  PhotosCell.swift
//  CachingImages
//
//  Created by xcismans on 08/10/2021.
//

import UIKit
import Kingfisher

class PhotosCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
 
    func configureCell(onePhotoData: PhotosData){
        let imgURL = URL(string: onePhotoData.download_url ?? "")
        
        titleLabel.text = onePhotoData.author
        img.kf.setImage(
            with: imgURL,
            placeholder: UIImage(named: "loading"),
            options:nil,
            progressBlock: { receivedSize, totalSize in
                // Progress updated
            },
            completionHandler: { result in
                
            }
        )
    }
}

//
//  DetailsPhotoViewController.swift
//  CachingImages
//
//  Created by xcismans on 10/10/2021.
//

import UIKit
import Kingfisher

class DetailsPhotoViewController: UIViewController {

    var imgURL : URL?
    var imgTitle: String?
    @IBOutlet weak var detailsImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = imgTitle
        self.detailsImage.kf.setImage(with: imgURL, placeholder: nil, options: nil, completionHandler: nil)
    }
    

}

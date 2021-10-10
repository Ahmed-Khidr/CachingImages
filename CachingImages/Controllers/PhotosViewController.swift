//
//  PhotosViewController.swift
//  CachingImages
//
//  Created by xcismans on 08/10/2021.
//

import UIKit
import Kingfisher

class PhotosViewController: UIViewController {

    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    var page: Int = 20
    var isPageRefreshing:Bool = false
    let dataSource = PhotosCollectionViewDataSource()
    lazy var photosViewModel : PhotosViewModel = {
        let viewModel = PhotosViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photosCollectionView.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            DispatchQueue.main.async {
                self?.photosCollectionView.reloadData()
            }
        }
        self.photosViewModel.callFuncToGetPhotosData(pageNum: String(page))
    }
}


extension PhotosViewController: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imgURL = URL(string: dataSource.data.value[indexPath.row].download_url ?? "")
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =  storyBoard.instantiateViewController(withIdentifier: "DetailsPhotoViewController") as! DetailsPhotoViewController
        vc.imgURL = imgURL
        vc.imgTitle = dataSource.data.value[indexPath.row].author
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width/2)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.photosCollectionView.contentOffset.y >= (self.photosCollectionView.contentSize.height - self.photosCollectionView.bounds.size.height)) {
            // loading only one time
                if !isPageRefreshing {
                    isPageRefreshing = true
                    print(page)
                    page = page + 20
                    self.photosViewModel.callFuncToGetPhotosData(pageNum: String(page))
                }
            }
    }
}

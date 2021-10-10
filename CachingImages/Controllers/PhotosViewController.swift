//
//  PhotosViewController.swift
//  CachingImages
//
//  Created by xcismans on 08/10/2021.
//

import UIKit

class PhotosViewController: UIViewController {

    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    let dataSource = PhotosCollectionViewDataSource()
    lazy var photosViewModel : PhotosViewModel = {
        let viewModel = PhotosViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photosCollectionView.dataSource = self.dataSource
        self.photosCollectionView.delegate = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            DispatchQueue.main.async {
                self?.photosCollectionView.reloadData()
            }
        }
        self.photosViewModel.callFuncToGetPhotosData()
        
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

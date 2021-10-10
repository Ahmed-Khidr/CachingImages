//
//  PhotosCollectionViewDataSource.swift
//  CachingImages
//
//  Created by xcismans on 08/10/2021.
//

import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class PhotosCollectionViewDataSource : GenericDataSource<PhotosData> ,UICollectionViewDataSource {

    // MARK: - data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (data.value.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.data.value[indexPath.row].id == "AdsImage"{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdsCell", for: indexPath) as! AdsCell
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as! PhotosCell
            cell.configureCell(onePhotoData: self.data.value[indexPath.row])
            return cell
        }
    }
}


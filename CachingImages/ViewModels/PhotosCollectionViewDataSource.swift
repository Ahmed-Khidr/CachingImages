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

class PhotosCollectionViewDataSource : GenericDataSource<PhotosData> ,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    private let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    
    
    // MARK: - Image Loading
    private func loadImage(imgUrl: String,completion: @escaping (UIImage?) -> ()) {
            utilityQueue.async {
                let url = URL(string: imgUrl)!
                
                guard let data = try? Data(contentsOf: url) else { return }
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    // MARK: - data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as! PhotosCell
        let photoData = self.data.value[indexPath.row]
        
        let itemNumber = NSNumber(value: indexPath.item)
        if let cachedImage = self.cache.object(forKey: itemNumber) {
            print("Using a cached image for item: \(itemNumber)")
            cell.img.image = cachedImage
        } else {
            self.loadImage(imgUrl: (photoData.download_url ?? "")) { [weak self] (image) in
            guard let self = self, let image = image else { return }
            cell.img.image = image
            self.cache.setObject(image, forKey: itemNumber)
                    }
                }
       return cell
    }
    // MARK: - delegate
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let cell = cell as? PhotosCell else { return }
                
                // 2
        let itemNumber = NSNumber(value: indexPath.item)
                
                // 3
        if let cachedImage = self.cache.object(forKey: itemNumber) {
            print("Using a cached image for item: \(itemNumber)")
            cell.img.image = cachedImage
        } else {
            self.loadImage(imgUrl: (data.value[indexPath.row].download_url ?? "")) { [weak self] (image) in
            guard let self = self, let image = image else { return }
            cell.img.image = image
            self.cache.setObject(image, forKey: itemNumber)
                    }
                }
            }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width/2)
    }
    

}


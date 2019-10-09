//
//  CachedImageView.swift
//  StackOverflowGurus
//
//  Created by Suman Chatterjee on 09/10/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit

class DiscardableImageCacheItem: NSObject, NSDiscardableContent {

    private(set) public var image: UIImage?
    var accessCount: UInt = 0

    public init(image: UIImage) {
        self.image = image
    }

    public func beginContentAccess() -> Bool {
        if image == nil {
            return false
        }

        accessCount += 1
        return true
    }

    public func endContentAccess() {
        if accessCount > 0 {
            accessCount -= 1
        }
    }

    public func discardContentIfPossible() {
        if accessCount == 0 {
            image = nil
        }
    }

    public func isContentDiscarded() -> Bool {
        return image == nil
    }

}


class CachedImageView: UIImageView {

    static let imageCache = NSCache<NSString, DiscardableImageCacheItem>()

    var shouldUseEmptyImage = true

    private var urlStringForChecking: String?
    private var emptyImage: UIImage?

    public convenience init(cornerRadius: CGFloat = 0, tapCallback: @escaping (() -> ())) {
        self.init(cornerRadius: cornerRadius, emptyImage: nil)
    }


    public init(cornerRadius: CGFloat = 0, emptyImage: UIImage? = nil) {
        super.init(frame: .zero)
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        self.emptyImage = emptyImage
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func loadImage(urlString: String, completion: (() -> ())? = nil) {
        image = nil

        self.urlStringForChecking = urlString

        let urlKey = urlString as NSString

        if let cachedItem = CachedImageView.imageCache.object(forKey: urlKey) {
            image = cachedItem.image
            completion?()
            return
        }

        guard let url = URL(string: urlString) else {
            if shouldUseEmptyImage {
                image = emptyImage
            }
            return
        }
        
        let network = Network()
        network.send(url: urlString) { [weak self] (result) in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    let cacheItem = DiscardableImageCacheItem(image: image)
                    CachedImageView.imageCache.setObject(cacheItem, forKey: urlKey)

                    if urlString == self?.urlStringForChecking {
                        self?.image = image
                        completion?()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion?()
            }
        }
    }
}

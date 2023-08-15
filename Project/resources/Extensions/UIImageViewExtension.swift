//
//  UIImageViewExtension.swift
//  Project
//
//  Created by Kiran Nayak on 15/08/23.
//

import Foundation
import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    /// This is used to load image using URLs and store it in cache
    /// - Parameter urlString: url string
    func load(urlString : String?) {
        // If image is already in cache, no need to load
        guard let urlString = urlString else {
            return
        }

        if let image = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = image
            return
        }
        guard let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}

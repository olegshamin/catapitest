//
//  UIImage+Extensions.swift
//  catapitest
//
//  Created by Oleg Shamin on 02.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// Asynchronously downloading and caching the image from URL
    ///
    /// - Parameter url: Url to the image
    /// - Parameter completion: Completion which is called if the image was downloaded
    public func loadImage(
        fromUrl url: URL?,
        completion: @escaping () -> ()
    ) {
        
        guard let imageUrl = url else {
            return
        }
        
        let cache = URLCache.shared
        let request = URLRequest(url: imageUrl)
        
        DispatchQueue.main.async {
            self.image = nil
        }

        DispatchQueue.global(qos: .background).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                    completion()
                }
            } else {
                
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in

                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {

                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            self.image = image
                            completion()
                        }
                    } else {
                        completion()
                    }

                }).resume()

            }
        }
    }
    
}

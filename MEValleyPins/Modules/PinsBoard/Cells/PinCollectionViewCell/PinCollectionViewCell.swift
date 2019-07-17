//
//  PinCollectionViewCell.swift
//  MEValleyPins
//
//  Created by Mohamed Mostafa on 7/16/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import UIKit
import MEValleyLoader

class PinCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var likedImageView: UIImageView!
    @IBOutlet var pinImageView: UIImageView!
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    
    var imageFetcher: ImageFetcherable!
    
    var pin: Pin!
    
    func configure(pin: Pin, imageFetcher: ImageFetcherable = MEValleyLoader.shared) {
        self.pin = pin
        self.imageFetcher = imageFetcher
        
        updateLikedStatus(liked: pin.isLikedByUser ?? false)
        setUserInfo(user: pin.user)
        setPinImage(pin: pin)
    }
    
    func updateLikedStatus(liked: Bool) {
        if liked {
            likedImageView.image = UIImage(asset: .like)
        } else {
            likedImageView.image = UIImage(asset: .unlike)
        }
    }
    
    func setPinImage(pin: Pin) {
        pinImageView.image = UIImage(asset: .imagePlaceholder)
        
        if let image = pin.imageUrls?.regular {
            if let imageUrl = URL(string: image) {
                imageFetcher?.getImage(with: imageUrl, completion: {[weak self, url = image] (pinImage) in
                    if url == self?.pin.imageUrls?.regular {
                        Dispatch.onMainThread {
                            self?.pinImageView.image = pinImage ?? UIImage(asset: .errorImage)
                        }
                    }
                })
            }
        }
    }
    
    func setUserInfo(user: User?) {
        userNameLabel.text = user?.name
        userImageView.image = UIImage(asset: .profilePlaceholder)
        if let userProfileImage = user?.profileImage?.small {
            if let userProfileImageUrl = URL(string: userProfileImage) {
                imageFetcher?.getImage(with: userProfileImageUrl, completion: {[weak self, url = userProfileImage] (profileImage) in
                    if url == self?.pin.user?.profileImage?.small {
                        Dispatch.onMainThread {
                            self?.userImageView.image = profileImage
                        }
                    }
                })
            }
        }
    }
    
}

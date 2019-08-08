//
//  SMVIdeoCollectionViewCell.swift
//  SwiftMiaTV
//
//  Created by Christian Romanelli on 8/3/19.
//  Copyright © 2019 3 Pixels Media. All rights reserved.
//

import UIKit

protocol VideoCollectionViewCellDelegate {
    func updateInfo(_ video: Video)
}

class SMVIdeoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var view: UIView!
    
    var delegate : VideoCollectionViewCellDelegate?
    var myVideo : Video!
    
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        //Called immediately after the system updates the focus to a new view. here we can control what to do when a gains or looses focus
        
        if self.isFocused {
            showFocus()
            //Tell the delegate the Cell is focused
            delegate?.updateInfo(myVideo)
            
        } else {
            removeFocus()
        }
    }
    
    
    func prepareTVCellWith(_ video : Video) {
        myVideo = video
        self.view.layer.cornerRadius = 20.0
        self.view.layer.borderColor = SMStore.shared.lightBlue.cgColor
        videoImage.image = UIImage(named: "swifty")
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    
    func showFocus() {
        self.view.layer.borderWidth = 5.0
        UIView.animate(withDuration: 0.3) {
            self.videoImage.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }
        //videoImage.adjustsImageWhenAncestorFocused = true
    }
    
    func removeFocus() {
        self.view.layer.borderWidth = 0
        UIView.animate(withDuration: 0.3) {
            self.videoImage.transform = CGAffineTransform.identity
        }
        //videoImage.adjustsImageWhenAncestorFocused = false
    }
}

//
//  SMButton.swift
//  SwiftMiaTVOS
//
//  Created by Christian Romanelli on 8/8/19.
//  Copyright © 2019 3 Pixels Media. All rights reserved.
//

import UIKit

class SMButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUpView()
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        
//        if self.isFocused {
//            growButton()
//        } else {
//            shrinkButton()
//        }
        
        //This is a different way to check if the View is going to be focused
        if context.nextFocusedView == self {
            growButton()
        } else {
            shrinkButton()
        }
    }

    func setUpView() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = 10.0
        
    }
    
    func growButton() {
        self.backgroundColor = SMStore.shared.lightBlue
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 10.0
            self.layer.shadowOpacity = 0.6
            self.layer.shadowOffset = CGSize(width: 14.0, height: 14.0)
        }

    }
    
    func shrinkButton() {
        self.backgroundColor = .clear
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform.identity
            self.layer.shadowOpacity = 0.0
        }
    }

}

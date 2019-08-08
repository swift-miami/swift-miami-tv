//
//  LoadingViewController.swift
//  SwiftMiaTV
//
//  Created by Christian Romanelli on 8/7/19.
//  Copyright © 2019 3 Pixels Media. All rights reserved.
//

import UIKit

class LoadingPhoneViewController: UIViewController {
    
    let api = SMApi.shared // API Singleton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.getVideoData { (completed) in
            if completed {
                self.goToMain()
            } else {
                print("There was a a problem getting Data")
            }
        }
    }
    
    func goToMain() {
        let main = IndexViewController(nibName: "indexView", bundle: nil)
        self.navigationController?.pushViewController(main, animated: false)
        
    }
    
    
}

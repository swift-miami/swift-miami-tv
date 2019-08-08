//
//  LoadingViewController.swift
//  SwiftMiaTVOS
//
//  Created by Christian Romanelli on 8/6/19.
//  Copyright © 2019 3 Pixels Media. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    let api = SMApi.shared // API Singleton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.getVideoData { (completed) in
            if completed {
                self.goToMain()
            } else {
                print("There was a problem getting Data")
            }
        }
    }
    
    
    func goToMain() {
        let main = MainViewController(nibName: "mainView", bundle: nil)
        self.navigationController?.pushViewController(main, animated: true)
    }
    
    
    
}

//
//  SMStore.swift
//  SwiftMiaTV
//
//  Created by Christian Romanelli on 8/3/19.
//  Copyright © 2019 3 Pixels Media. All rights reserved.
//

import UIKit

// iOS & tvOS Shared Store class

class SMStore {
    static let shared = SMStore()
    private init() { }

    var sourceVideos = [Video]()
    
    var shouldSetTVBehavior = true
    
    //Colors :
    let lightBlue = UIColor(red:0.35, green:0.63, blue:0.94, alpha:1.0)
    let titleBlue = UIColor(red:0.46, green:0.72, blue:0.84, alpha:1.0)
    let indexGray = UIColor(red:0.28, green:0.28, blue:0.29, alpha:1.0)
    let lightGray = UIColor(red:0.80, green:0.83, blue:0.92, alpha:1.0)
    
    
    //Sizes
    var videoCellSize : CGSize {
        get {
            switch UIDevice.current.userInterfaceIdiom {
            case .tv:
                //In case we are using an AppleTV
                //This size was calculated using a 16:9 ratio and the Apple suggested cell width for a 3 column grid
                //link : https://developer.apple.com/design/human-interface-guidelines/tvos/visual-design/layout/
                return CGSize(width: 548, height: 308)
                
            case .phone:
                //In case we are using an iPhone
                return CGSize.zero
                
            default:
                // There are also .pad , .carPlay, .unspecified
                return CGSize.zero
            }
        }
    }
    
    var videoCellVerticalSpacing : CGFloat {
        get {
            switch UIDevice.current.userInterfaceIdiom {
            case .tv:
                // Same case as VIDEO_CELL_SIZE
                return 100.0
                
            case .phone:
                return 0.0
            default:
                
                return 0.0
            }
        }
    }
    
    var videoCellHorizontalSpacing : CGFloat {
        get {
            switch UIDevice.current.userInterfaceIdiom {
            case .tv:
                // Same case as VIDEO_CELL_SIZE
                return 48.0
                
            case .phone:
                return 0.0
            default:
                
                return 0.0
            }
        }
    }
    

    

}

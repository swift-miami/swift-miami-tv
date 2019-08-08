//
//  mainHelper.swift
//  SwiftMiaTVOS
//
//  Created by Christian Romanelli on 8/7/19.
//  Copyright © 2019 3 Pixels Media. All rights reserved.
//

import UIKit

extension MainViewController {
    
    
    
    func prepareCollectionView() {
        // Registering Nib for UICOllectionView
        let nib = UINib(nibName: "videoTVCell", bundle: nil)
        videosCollection.register(nib, forCellWithReuseIdentifier: "videoCell")
        videosCollection.dataSource = self
        videosCollection.delegate = self
        
        //Setting CollectionViewLayout
        flowLayout.estimatedItemSize = store.videoCellSize
        flowLayout.minimumLineSpacing = store.videoCellHorizontalSpacing
        flowLayout.minimumInteritemSpacing = store.videoCellVerticalSpacing
        flowLayout.scrollDirection = .horizontal
        videosCollection.collectionViewLayout = flowLayout
        videosCollection.backgroundColor = .clear
    }
    
    func prepareSegmentControl() {
        typeSwitcher.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        typeSwitcher.setTitle("All", forSegmentAt: 0)
        typeSwitcher.setTitle("MeetUp", forSegmentAt: 1)
        typeSwitcher.setTitle("Club", forSegmentAt: 2)
        typeSwitcher.addTarget(self, action: #selector(updateVideos), for: .primaryActionTriggered)
        let attrOff = [NSAttributedString.Key.foregroundColor : UIColor.white]
        let attrOn = [NSAttributedString.Key.foregroundColor : store.lightBlue]
        typeSwitcher.setTitleTextAttributes(attrOn, for: .focused)
        typeSwitcher.setTitleTextAttributes(attrOn, for: .selected)
        typeSwitcher.setTitleTextAttributes(attrOff, for: .normal)
        typeSwitcher.selectedSegmentIndex = 0
    }
    
    func prepareFocusGuide() {
        let focusGuide = UIFocusGuide()
        
        //Add the FocusGuide to the layout... is IMPORTANT to do it
        //before setting the anchors
        self.view.addLayoutGuide(focusGuide)
        
        //Indicate where to transfer the focus
        focusGuide.preferredFocusEnvironments = [typeSwitcher]
        
        //Set the focusGuide size
        focusGuide.heightAnchor.constraint(equalToConstant: 20).isActive = true
        focusGuide.widthAnchor.constraint(equalToConstant: 1920).isActive = true
        
        //Position the focusGuide
        focusGuide.topAnchor.constraint(equalTo: typeSwitcher.bottomAnchor).isActive = true
        focusGuide.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        
    }
}

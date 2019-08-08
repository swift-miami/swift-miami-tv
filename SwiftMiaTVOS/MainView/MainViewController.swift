//
//  MainViewController.swift
//  SwiftMiaTVOS
//
//  Created by Christian Romanelli on 8/3/19.
//  Copyright © 2019 3 Pixels Media. All rights reserved.
//

import UIKit
import AlamofireImage

class MainViewController: UIViewController, VideoCollectionViewCellDelegate {
    
    @IBOutlet weak var membersButton: SMButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var typeSwitcher: UISegmentedControl!
    @IBOutlet weak var videosCollection: UICollectionView!    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    let store = SMStore.shared //Model Singleton
    var sourceVideos : [Video]!
    var videos : [Video]!
    var section : MeetUpType!
    
    
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [videosCollection]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sourceVideos = store.sourceVideos
        videos = sourceVideos.sorted(by: {$0.id < $1.id})
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareViews()
        prepareSegmentControl()
        prepareCollectionView()
        prepareFocusGuide()
    }
    
    @objc func updateVideos(_ sender : UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            videos = sourceVideos
            section = .all
            break
        case 1:
            videos = sourceVideos.filter({$0.type == .meetup}).sorted(by: {$0.id < $1.id})
            section = .meetup
            break
        case 2:
             videos = sourceVideos.filter({$0.type == .algorithm}).sorted(by: {$0.id < $1.id})
             section = .algorithm
            break
        default:
            print("Unhandled Status")
        }
        
        self.videosCollection.performBatchUpdates({
           self.videosCollection.reloadSections(IndexSet(integer: 0))
        }) { (_) in
            self.videosCollection.scrollToItem(at: IndexPath(item: 0, section: 0), at: UICollectionView.ScrollPosition.left, animated: true)
            self.setNeedsFocusUpdate()
            self.updateFocusIfNeeded()
        }
    }
    


    
    func updateInfo(_ video: Video) {
        //This is the delegate method that updates the main UI
        
        //Update the background Image
        if let bgURL = video.previewImage {
            backgroundView.af_setImage(withURL: bgURL, imageTransition: .crossDissolve(0.5))
        }
        
        //Update Info labels
        titleLabel.text = video.title
        dateLabel.text = video.date
        descriptionLabel.text = "Hosted by : \(video.hosts) \n\n \(video.description)"
    }


}

extension MainViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let videos = self.videos else {return 0}
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! SMVIdeoCollectionViewCell
        
        let video = videos[indexPath.row]
        cell.delegate = self
        cell.prepareTVCellWith(video)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        print("Did Highlight Cell")
    }
    

    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video = videos[indexPath.row]
        goToPlayerWith(video)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
        
        return true
    }
}


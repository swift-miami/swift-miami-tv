//
//  IndexViewController.swift
//  SwiftMiaTV
//
//  Created by Christian Romanelli on 8/7/19.
//  Copyright © 2019 3 Pixels Media. All rights reserved.
//

import UIKit
import AVKit

enum Direction {
    case vertical
    case horizontal
}

class IndexViewController: UIViewController {
    
    let store = SMStore.shared
    
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var typeSwitcher: UISegmentedControl!
    @IBOutlet weak var videosTable: UITableView!
    var sourceVideos : [Video]!
    var videos : [Video]!
    var section : MeetUpType!
    var orientation : Direction! = .vertical
    var playerLayer : AVPlayerLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews()
        sourceVideos = store.sourceVideos
        videos = sourceVideos
        prepareTableView()
    }
    
    func prepareViews() {
        //imageView.isHidden = true
        containerView.backgroundColor = .black
        typeSwitcher.tintColor = store.lightBlue
        typeSwitcher.addTarget(self, action: #selector(updateVideos), for: .valueChanged)
        self.navigationController?.navigationBar
        .isHidden = true
        self.view.backgroundColor = store.indexGray
        
    }
    
    func prepareTableView() {
        closeButton.alpha = 0.0
        let nib = UINib(nibName: "videoCell", bundle: nil)
        videosTable.register(nib, forCellReuseIdentifier: "videoCell")
        videosTable.dataSource = self
        videosTable.delegate = self
        videosTable.estimatedRowHeight = UITableView.automaticDimension
        videosTable.backgroundColor = .clear
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(rotateVideo))
        containerView.addGestureRecognizer(tap)
    }
    
    @objc func rotateVideo() {

        UIView.animate(withDuration: 0.2, animations: {
            self.closeButton.alpha = 1.0
            let radians = CGFloat(90.0 * Double.pi / 180)
            let rot = CATransform3DMakeRotation(radians, 0.0, 0.0, 1.0)
            self.playerLayer.transform = rot
            self.playerLayer.frame = self.view.frame
        }) { (_) in
            
            self.orientation = .horizontal
        }
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        if self.orientation == .horizontal {
            UIView.animate(withDuration: 0.2, animations: {
                self.playerLayer.transform = CATransform3DIdentity
                self.playerLayer.frame = self.containerView.frame
                self.closeButton.alpha = 0.0
            }) { (_) in
                self.orientation = .vertical
            }
            
            
        }
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
        
        self.videosTable.performBatchUpdates({
            self.videosTable.reloadSections(IndexSet(integer: 0), with: UITableView.RowAnimation.automatic)
            
            //self.videosCollection.reloadSections(IndexSet(integer: 0))
        })
    }
    
    
}

extension IndexViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell") as! VideoTableViewCell
        
        cell.prepareCellWith(videos[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let video = videos[indexPath.row]
        //goToPlayerWith(video)
        UIView.animate(withDuration: 0.2, animations: {
            self.imageView.alpha = 0.0
        }) { (_) in
            self.makePlayerLayerWith(video)
        }
        
    }
    
    func goToPlayerWith(_ video: Video) {
        let playerVC = AVPlayerViewController()
        guard let url = video.url else {
            assertionFailure("There was a problem unwrapping the video's URL")
            return
        }
        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        
        playerVC.player = AVQueuePlayer(playerItem: item)
        present(playerVC, animated: true) {
            playerVC.player?.play()
        }
    }
    
    func makePlayerLayerWith(_ video: Video) {
        guard let url = video.url else {
            assertionFailure("There was a problem unwrapping the video's URL")
            return
        }
        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: item)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = containerView.bounds
        containerView.layer.addSublayer(playerLayer)
        player.play()
    }
}

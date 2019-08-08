//
//  videoHelper.swift
//  SwiftMiaTVOS
//
//  Created by Christian Romanelli on 8/4/19.
//  Copyright © 2019 3 Pixels Media. All rights reserved.
//

import Foundation
import AVKit

extension MainViewController {
    
    func goToPlayerWith(_ video: Video) {
        let playerVC = AVPlayerViewController()
        guard let url = video.url else {
            assertionFailure("There was a problem unwrapping the video's URL")
            return
        }
        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        
        if #available(tvOS 10.0, *) {
            //In order to display video´s metadata on the dropdown menu. you need to create it
            item.externalMetadata = makeExternalMetadata(video)
        }
        
        playerVC.player = AVQueuePlayer(playerItem: item)
        present(playerVC, animated: true) {
            playerVC.player?.play()
        }
    }
    
    /*This function was taken from : https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/MediaPlaybackGuide/Contents/Resources/en.lproj/UsingAVKitPlatformFeatures/UsingAVKitPlatformFeatures.html#//apple_ref/doc/uid/TP40016757-CH5-SW19
     to 
    */
    func makeExternalMetadata(_ video : Video) -> [AVMetadataItem] {
        var metadata = [AVMetadataItem]()
        
        // Build title item
        let titleItem =
            makeMetadataItem(AVMetadataIdentifier.commonIdentifierTitle.rawValue, value: video.title)
        metadata.append(titleItem)
        
        // Build artwork item
        if let image = UIImage(named: video.placeholderImage), let pngData = image.pngData() {
            let artworkItem =
                makeMetadataItem(AVMetadataIdentifier.commonIdentifierArtwork.rawValue, value: pngData)
            metadata.append(artworkItem)
        }
        
        // Build description item
        let hosts = video.hosts
        let descItem =
            makeMetadataItem(AVMetadataIdentifier.commonIdentifierDescription.rawValue, value: "Hosted by: \(hosts) \n on \(video.date)")
        metadata.append(descItem)

        // Build rating item
        let ratingItem =
            makeMetadataItem(AVMetadataIdentifier.iTunesMetadataContentRating.rawValue, value: "PG-13")
        metadata.append(ratingItem)

        // Build genre item
        let genreItem =
            makeMetadataItem(AVMetadataIdentifier.quickTimeMetadataGenre.rawValue, value: "\(video.type)")
        metadata.append(genreItem)
        
        return metadata
    }
    
    private func makeMetadataItem(_ identifier: String,
                                  value: Any) -> AVMetadataItem {
        let item = AVMutableMetadataItem()
        item.identifier = AVMetadataIdentifier(rawValue: identifier)
        item.value = value as? NSCopying & NSObjectProtocol
        item.extendedLanguageTag = "und"
        return item.copy() as! AVMetadataItem
    }

    
}

//
//  VideoTableViewCell.swift
//  SwiftMiaTV
//
//  Created by Christian Romanelli on 8/8/19.
//  Copyright © 2019 3 Pixels Media. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    let store = SMStore.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func prepareCellWith(_ video : Video) {
        backgroundColor = .clear
        titleLabel.text = video.title
        titleLabel.textColor = store.titleBlue
        detailLabel.textColor = store.lightGray
        descriptionLabel.textColor = store.lightGray
        detailLabel.text = "Hosted by: \(video.hosts) on \(video.date)"
        descriptionLabel.text = video.description
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

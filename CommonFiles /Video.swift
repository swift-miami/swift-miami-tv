//
//  Video.swift
//  SwiftMiaTV
//
//  Created by Christian Romanelli on 8/3/19.
//  Copyright © 2019 3 Pixels Media. All rights reserved.
//

import Foundation

enum MeetUpType : String , Codable {
    case meetup //Meet Up Videos
    case algorithm // Algorithm Club Videos
    case all
}


struct Video : Codable {
    var id : Int
    var title : String?
    var description : String
    var previewImage : URL?
    var placeholderImage : String = "tvosSwift"
    var hosts : String
    var date : String
    var url : URL?
    var type : MeetUpType
}

struct AirTableResponse : Codable {
    var records : [Record]
}

struct Record : Codable {
    var id : String
    var video : Video
    var createdTime : String
    
    
    enum CodingKeys : String, CodingKey {
        case id
        case video = "fields"
        case createdTime
    }
}

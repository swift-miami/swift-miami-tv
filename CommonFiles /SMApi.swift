//
//  SMApi.swift
//  SwiftMiaTV
//
//  Created by Christian Romanelli on 8/7/19.
//  Copyright © 2019 3 Pixels Media. All rights reserved.
//

import Foundation
import Alamofire


class SMApi {
    
    static let shared = SMApi()
    let store = SMStore.shared
    private init() { }
    
    let apiURL = "https://api.airtable.com/v0/appS0bKg10BHm3af8/Table%201?api_key=keyKP4qFWOGiA5f2z"
    
    func getVideoData(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: apiURL) else { return }

        Alamofire.request(url).responseData { (result) in
            guard let data = result.data else  { return }
            let decoder = JSONDecoder()
            do {
                let videos = try decoder.decode(AirTableResponse.self, from: data)
                for record  in videos.records {
                    self.store.sourceVideos.append(record.video)
                }
                completion(true)

            } catch {
                print("Problem creating data")
                print(error)
                completion(false)
            }
        }
        
//        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//            guard let data = data else { return }
//

//        }
//        DispatchQueue.main.async {
//            task.resume()
//        }
        
    }
}

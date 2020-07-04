//
//  ImgurAPI.swift
//  CatLover
//
//  Created by Bruno Maciel on 7/3/20.
//  Copyright © 2020 Bruno Maciel. All rights reserved.
//

import Foundation
import Alamofire

class ImgurAPI {
    static private let serviceURL = "https://api.imgur.com/3/gallery/search/?q=cats"
    
    
    class func requestCatImages(onComplete: @escaping (ImgurData?) -> (Void)) {
        let header = [ "Authorization": "Client-ID 1ceddedc03a5d71" ]
        
        Alamofire.request(serviceURL, method: .get, headers: header).responseJSON { (response) in
            guard let data = response.data,
                let imgurData = try? JSONDecoder().decode(ImgurData.self, from: data)
                else {
                    //print("\n\nHeaders: \(response.response?.allHeaderFields)")
                    onComplete(nil)
                    return
                }
            onComplete(imgurData)
        }
    }
}

//
//  ImgurClasses.swift
//  CatLover
//
//  Created by Bruno Maciel on 7/3/20.
//  Copyright © 2020 Bruno Maciel. All rights reserved.
//

import Foundation

struct ImgurData: Codable {
    var data: [ImgurPost]
}

struct ImgurPost: Codable {
    var id: String
    var link: String
    var images: [ImgurImage]? // É optional pois alguns posts retornam sem a key "images"
}

struct ImgurImage: Codable {
    var width: Int
    var height: Int
    var size: Int
    var link: String
}

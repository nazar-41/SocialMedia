//
//  ExploreCardModel.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 17/10/2022.
//

import Foundation


struct ExploreCardModel: Identifiable, Codable, Hashable{
    let id: String
    let author: String
    let downloadURL: String
    
    enum CodingKeys: String, CodingKey{
        case id, author
        case downloadURL = "download_url"
    }
    
    var isLiked: Bool = false

}


/*
 
 {
    "id":"117",
    "author":"Daniel Ebersole",
    "width":1544,
    "height":1024,
    "url":"https://unsplash.com/photos/Q14J2k8VE3U",
    "download_url":"https://picsum.photos/id/117/1544/1024"}
 
 */

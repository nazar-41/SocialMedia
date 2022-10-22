//
//  PostCardModel.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 22/10/2022.
//

import Foundation


struct PostCardModel: Identifiable{
    var id = UUID().uuidString
    
    let author: ExploreCardModel
    var isLiked: Bool
    //let comments: [String]
}

//
//  PostModel.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 27/10/2022.
//

import Foundation


struct PostModel: Identifiable, Codable{
    var id: String
    
    let author: String
    let text: String
    let image: String?
    let date: String
    var likes: [String]
    var comments: [PostCommentModel]?
}


struct PostCommentModel: Codable, Identifiable{
    var id = UUID().uuidString
    let sender: String
    let comment: String
}

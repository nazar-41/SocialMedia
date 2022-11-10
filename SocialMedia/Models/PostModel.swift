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
    let likes: String
}

//
//  ExploreCardModel.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 17/10/2022.
//

import Foundation


struct ExploreCardModel: Identifiable, Codable{
    let id: String
    let author: String
    let downloadURL: String
    
    enum CodingKeys: String, CodingKey{
        case id, author
        case downloadURL = "download_url"
    }
}

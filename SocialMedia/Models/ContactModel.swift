//
//  ContactModel.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 19/10/2022.
//

import SwiftUI


struct ContactModel: Identifiable, Codable, Hashable{
    let id: String
    let name: String
    let surname: String
    let username: String
    let email: String
    let phoneNumber: String
    let createdDate: String
    var profile_image: String
    var followers: [String]
    var following: [String]
    var receivedConnections: [String]
    var sendedConnections: [String]
    
    let not_token: String
}

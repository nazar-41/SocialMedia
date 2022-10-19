//
//  ContactModel.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 19/10/2022.
//

import SwiftUI


struct ContactModel: Identifiable, Codable{
    var id = UUID().uuidString
    let name: String
    let surname: String
    let username: String
    let email: String
    let phoneNumber: String
  //  let photo: UIImage
}

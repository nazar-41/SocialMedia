//
//  AlertModel.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 21/10/2022.
//

import Foundation

struct AlertModel: Identifiable{
    var id = UUID().uuidString
    let title: String
    let message: String
}

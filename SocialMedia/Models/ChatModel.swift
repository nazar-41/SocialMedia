//
//  ChatModel.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 19/10/2022.
//

import Foundation

struct FakeChatModel: Identifiable{
    var id = UUID().uuidString
    let contact: ContactModel
    let isUser: Bool
    let message: String
    
}

struct SubmittedChatMessageModel: Identifiable, Codable{
    var id = UUID().uuidString
    let user: ContactModel
    let message: String
}


struct ReceivingChatMessageModel: Identifiable, Codable{
    var id = UUID().uuidString
    let date: Date
    let message: String
    
    let user: ContactModel
}

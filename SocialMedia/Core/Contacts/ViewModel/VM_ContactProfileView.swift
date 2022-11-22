//
//  VM_ContactProfileView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 22/11/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class VM_ContactProfileView: ObservableObject{
    private let database = Firestore.firestore()
    
    func sendConnction(contactID: String, list: [ContactModel]?, currentUserID: String?){
        guard let list = list,
        let currentUserID = currentUserID else{return}
        
        guard var contact = list.first(where: {$0.id == contactID}) else{
            print("\n invalid contact")
            return
        }
        
        
        guard !contact.receivedConnections.contains(currentUserID) else{
            print("\n connection can't be send twice: user: \(currentUserID)")
            return
        }
        
        contact.receivedConnections.append(currentUserID)
        
        do {
            try database.collection("users_list").document(contactID).setData(from: contact)
        } catch {
            print("\n error sending connection to user: \(error)")
        }
        
    }
}

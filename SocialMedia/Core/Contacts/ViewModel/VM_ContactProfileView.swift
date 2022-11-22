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
    
    @Published var followers: Int = 0
    @Published var followings: Int = 0
    @Published var posts: Int = 0
    
    func sendConnction(contact: ContactModel, currentUser: ContactModel?){
        guard var currentUser = currentUser else{return}
                
        guard !contact.receivedConnections.contains(currentUser.id) else{
            print("\n connection can't be send twice: user: \(currentUser)")
            return
        }
        
        var copiedContact = contact
        
        copiedContact.receivedConnections.append(currentUser.id)
        currentUser.sendedConnections.append(copiedContact.id)
        
        do {
            try database.collection("users_list").document(contact.id).setData(from: copiedContact)
            try database.collection("users_list").document(currentUser.id).setData(from: currentUser)
        } catch {
            print("\n error sending connection to user: \(error)")
        }
    }
    
    func getContactInfo(contact: ContactModel){
        self.followers = contact.followers.count
        self.followings = contact.following.count
        
    }
}

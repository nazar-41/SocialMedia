//
//  VM_InvitedFriendCardView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 22/11/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class VM_InvitedFriendCardView: ObservableObject{
    @Published var contact: ContactModel?
    
    private let database = Firestore.firestore()
    
    
    init(id: String, list: [ContactModel]?){
        getContact(id: id, list: list)
    }
    
    private func getContact(id: String, list: [ContactModel]?){
        
        guard let contact = list?.first(where: {$0.id == id}) else{return}
        
        self.contact = contact
        
    }
    
    func acceptContact(currentUser: ContactModel?){
        guard var currentUser = currentUser,
              var contact = contact else{return}
        
        currentUser.followers.append(contact.id)
        currentUser.receivedConnections.removeAll(where: {$0 == contact.id})
        
        contact.following.append(currentUser.id)
        contact.sendedConnections.removeAll(where: {$0 == currentUser.id})
        
        do {
            try database.collection("users_list").document(currentUser.id).setData(from: currentUser)
            try database.collection("users_list").document(contact.id).setData(from: contact)
        } catch {
            print("\n error accepting connection: \(error)")
        }
    }
    
    func rejectContact(){
        
    }
    
    /*
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
     */
}

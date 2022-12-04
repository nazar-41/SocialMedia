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
    
    func acceptRequest(currentUser: ContactModel?){
        guard var currentUser = currentUser,
              var contact = contact else{return}
        
        currentUser.followers.append(contact.id)
        currentUser.receivedConnections.removeAll(where: {$0 == contact.id})
        
        contact.following.append(currentUser.id)
        contact.sendedConnections.removeAll(where: {$0 == currentUser.id})
        
        do {
            try database.collection("users_list").document(currentUser.id).setData(from: currentUser)
            try database.collection("users_list").document(contact.id).setData(from: contact)
            
            let notificationModel = NotificationModel(token: contact.id, title: "New connection", body: "\(currentUser.name) \(currentUser.surname) sent you connection request")
            
            notify(model: notificationModel)
        } catch {
            print("\n error accepting connection: \(error)")
        }
    }
    
    func rejectRequest(currentUser: ContactModel?){
        guard var currentUser = currentUser,
              var contact = contact else{return}
        
        currentUser.receivedConnections.removeAll(where: {$0 == contact.id})
        contact.sendedConnections.removeAll(where: {$0 == currentUser.id})
        
        do {
            try database.collection("users_list").document(currentUser.id).setData(from: currentUser)
            try database.collection("users_list").document(contact.id).setData(from: contact)
        } catch {
            print("\n error rejecting connection: \(error)")
        }
    }
    
    func cancelSentRequest(currentUser: ContactModel?){
        guard var currentUser = currentUser,
              var contact = contact else{return}
        
        currentUser.receivedConnections.removeAll(where: {$0 == contact.id})
        contact.sendedConnections.removeAll(where: {$0 == currentUser.id})
        
        do {
            try database.collection("users_list").document(currentUser.id).setData(from: currentUser)
            try database.collection("users_list").document(contact.id).setData(from: contact)
        } catch {
            print("\n error cancelling connection: \(error)")
        }
    }
    
    private func notify(model: NotificationModel){
        guard let url = URL(string: Constants.firebaseURL) else{
            print("\n error: invalid notification url")
            return
        }
        
        let json: [String : Any] = [
            "to" : model.token,
            "notification" : [
                "title": model.title,
                "body": model.body
            ],
            "data": []
        ]
        
        let serverKey = "AAAAoYEOGlw:APA91bG5s0_d92nZRHm7BDIz54Fc0sZ1gHrkgfC59obCyR-1ywOr5BW0QPhw2wtIE2EI0BY68vo-pjT-GA-kRytpz25abjmZzlnXyUCIL9QDfbFLxYD7BIe9-xK4abIDgzxBHvQKVwD7"
        
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
        
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { _, _, error in
            guard error == nil else{
                print("\n error posting notification: \(error)")
                return
            }
            
            print("SUCCESS")
            
            
            
        }
        
        
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

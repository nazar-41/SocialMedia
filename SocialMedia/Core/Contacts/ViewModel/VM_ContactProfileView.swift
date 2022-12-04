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
            
            print("\n here")
            
            let token = "f25ptlbuSUwWtr0MsnKuhI:APA91bE0wazWI1iHH9wZFqNTh6_OiLcphhJ_nTU7Khcfj0we1r-XWdeFWvIjJVeKulmM-eBM3sHl9mmvSRpYx8xvoToQTBBiUgIEQdWTQAEeaNtlC75EPRCwlZdrvawD5TsVuIHY9Iv5"
            
            let notificationModel = NotificationModel(token: token, title: "New connection", body: "\(currentUser.name) \(currentUser.surname) sent you connection request")
            
            notify(model: notificationModel)
            
        } catch {
            print("\n error sending connection to user: \(error)")
        }
    }
    
    func getContactInfo(contact: ContactModel){
        self.followers = contact.followers.count
        self.followings = contact.following.count
        
    }
    
    private func notify(model: NotificationModel){
        guard let url = URL(string: Constants.firebaseURL) else{
            print("\n error: invalid notification url")
            return
        }
        
        
        let json: [String : Any] = [
            "token" : model.token,
            "notification" : [
                "title": model.title,
                "body": model.body
            ],
            "data": []
        ]
        
        let serverKey = "AAAAoYEOGlw:APA91bG5s0_d92nZRHm7BDIz54Fc0sZ1gHrkgfC59obCyR-1ywOr5BW0QPhw2wtIE2EI0BY68vo-pjT-GA-kRytpz25abjmZzlnXyUCIL9QDfbFLxYD7BIe9-xK4abIDgzxBHvQKVwD7"
        
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
        } catch {
            print("\n error converting data to JSON: \(error)")
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
        
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { data, res, error in
//            guard error == nil else{
//                print("\n error posting notification: \(String(describing: error))")
//                return
//            }
            
            guard let response = res as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else{
                print("\n error: invlalid url response: \(String(describing: res))")
                return
            }
            
            guard let data = data else{
                print("\n error: invalid data")
                return
            }
            print("\n SUCCESS")
                        
        }
    }
}

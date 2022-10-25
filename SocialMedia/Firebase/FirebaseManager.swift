//
//  FirebaseManager.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 21/10/2022.
//

import Foundation
import FirebaseFirestore


class FirebaseManager: ObservableObject{
    
    @Published var users: [ContactModel] = []
    @Published var addSuccess: Bool = false
    
    private let database = Firestore.firestore()
    
    init(){
        fetchData()
    }
    
    func fetchData(){
        database.collection("users_list").getDocuments() { snapshot, error in
            guard error == nil else{
                print("error fetching firebase firestore")
                return
            }
            guard let snapshot = snapshot else{
                print("invalid firestore snapshot")
                return
            }
            guard !snapshot.documents.isEmpty else {
                print("database is empty")
                return
            }
            
            //MARK: update list on the main thread
            DispatchQueue.main.async {
                self.users = snapshot.documents.map { document in
                    return ContactModel(id: document.documentID,
                                        name: self.unwrappedValue(document: document, fieldName: "name"),
                                        surname: self.unwrappedValue(document: document, fieldName: "surname"),
                                        username: self.unwrappedValue(document: document, fieldName: "username"),
                                        email: self.unwrappedValue(document: document, fieldName: "email"),
                                        phoneNumber: self.unwrappedValue(document: document, fieldName: "mobile"),
                                        createdDate: self.unwrappedValue(document: document, fieldName: "created_date"))
                }
            }
        }
    }
    
    private func unwrappedValue(document: QueryDocumentSnapshot, fieldName: String)-> String{
        return document[fieldName] as? String ?? "-"
    }
    
    
    
    func addUser(user: ContactModel){
        let data: [String: Any] = ["name" : user.name,
                                   "surname" : user.surname,
                                   "username" : user.username,
                                   "email" : user.email,
                                   "mobile" : user.phoneNumber,
                                   "created_date" : user.createdDate
                                   
        ]
        
        database.collection(Constants.fb_userslist).addDocument(data: data) { error in
            guard error == nil else{
                print("error adding data: \(String(describing: error))")
                return
            }
            
            self.fetchData()
            self.addSuccess = true
        }
    }
}

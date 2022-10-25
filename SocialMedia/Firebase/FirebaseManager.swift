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
    
    let database = Firestore.firestore()
    
//    init(){
////        fetchData()
//        self.fetchData()
////        self.addData()
//    }
    
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
            
//            for document in snapshot.documents{
//                print("\(document.documentID) => \(document.data())")
//            }
            
            //MARK: update list on the main thread
            DispatchQueue.main.async {
//                self.users = snapshot.documents.map { document in
////                    return ContactModel(id: document.documentID,
////                                        name: self.unwrappedValue(document: document, fieldName: "name"),
////                                        surname: self.unwrappedValue(document: document, fieldName: "surname"),
////                                        username: self.unwrappedValue(document: document, fieldName: "username"),
////                                        email: self.unwrappedValue(document: document, fieldName: "email"),
////                                        phoneNumber: self.unwrappedValue(document: document, fieldName: "mobile"),
////                                        createdDate: self.unwrappedValue(document: document, fieldName: "created_date"))
//                    return ContactModel(id: document.documentID,
//                                        name: document["name"] as? String ?? "-",
//                                        surname: document["surname"] as? String ?? "-",
//                                        username: document["username"] as? String ?? "-",
//                                        email: document["email"] as? String ?? "-",
//                                        phoneNumber: document["mobile"] as? String ?? "-",
//                                        createdDate: document["created_date"] as? String ?? "-")
//                }
//
                for document in snapshot.documents{
                    var newDocument = ContactModel(id: document.documentID,
                                                   name: document["name"] as? String ?? "-",
                                                   surname: document["surname"] as? String ?? "",
                                                   username: document["username"] as? String ?? "",
                                                   email: document["email"] as? String ?? "",
                                                   phoneNumber: document["mobile"] as? String ?? "",
                                                   createdDate: document["created_date"] as? String ?? "")
                    
                  //  print(newDocument)
                    self.users.append(newDocument)
                }
                
                print("got list like: \(self.users)")
                
            }
            

        }
    }
    
    private func unwrappedValue(document: QueryDocumentSnapshot, fieldName: String)-> String{
        return document[fieldName] as? String ?? "-"
    }
    
    
    
    private func addData(){
        let data: [String: Any] = ["name" : "Maksat",
                                   "surname" : "Meredow",
                                   "username" : "max41",
                                   "email" : "mafw",
                                   "mobile" : "fdfdf",
                                   "created_date" : "yesterday"
        
        ]
        
        database.collection(Constants.fb_userslist).addDocument(data: data) { error in
            guard error == nil else{
                print("error adding data: \(error)")
                self.fetchData()
                return
            }
            
            self.fetchData()
        }
    }
}

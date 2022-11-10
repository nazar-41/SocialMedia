//
//  GlobalDowload.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 28/10/2022.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class GlobalDownload: ObservableObject{
        
    private let database = Firestore.firestore()

    
    @Published var userList: [ContactModel]? = nil
    @Published var currentUser: ContactModel? = nil
    @Published var postList: [PostModel]? = nil

    @AppStorage("email") private var currentUserEmail: String = ""
    
    init(){
        getUserList()
        getCurrentUser()
       // getPostList()
        getPostList2()
    }
    
    
    private func getUserList(){
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
                self.userList = snapshot.documents.map { document in
                    return ContactModel(id: document.documentID,
                                        name: document["name"] as? String ?? "-",
                                        surname: document["surname"] as? String ?? "-",
                                        username:  document["username"] as? String ?? "-",
                                        email: document["email"] as? String ?? "-",
                                        phoneNumber: document["mobile"] as? String ?? "-",
                                        createdDate: document["created_date"] as? String ?? "-",
                                        profile_image: document["profile_image"] as? String ?? "")}
                
              //  print("userslist: \(self.userList)")
                
                if self.currentUser == nil{
                    self.getCurrentUser()
                }
            }
        }
        
    }
    
    private func getCurrentUser(){
        guard let userList = userList else{
            print("\n user list is not found")
            return
        }
        
        currentUser = userList.first(where: {$0.email == currentUserEmail})
        print("currentuser: \(currentUser)")
        
        if self.userList == nil{
            print("\n reload user data")
            getCurrentUser()
        }
    }
    /*
    private func getPostList(){
        database.collection("posts").getDocuments() { snapshot, error in
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
                self.postList = snapshot.documents
                    .map { document in
                        return PostModel(author: document["author"] as? String ?? "-",
                                         text: document["text"] as? String ?? "-",
                                         image: document["image"] as? String ?? "-",
                                         date: document["date"] as? String ?? "-",
                                         likes: document["likes"] as? String ?? "-")
                        
                    }
                    .sorted(by: { self.getDateFromString(inputDate: $0.date) > self.getDateFromString(inputDate: $1.date) })

                
                
                
                
              //  print("postlist: \(self.postList)")
            }
        }
    }
     */
    
    private func getPostList2(){
        database.collection("posts").addSnapshotListener {[weak self] querySnapshot, error in
            guard error == nil else{
                print("\n error getting post list: \(String(describing: error))")
                return
            }
            
            guard let posts = querySnapshot?.documents else{
                print("\n error fetching documents")
                return
            }
            
            guard let self = self else{return}
            
            self.postList = posts.compactMap { post -> PostModel? in
                do{
                    return try post.data(as: PostModel.self)
                }catch{
                    print("\n error decoding post into Postmodel: \(error)")
                    return nil
                }
            }
        }
    }
    
    private func getDateFromString(inputDate: String)-> Date{
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        return olDateFormatter.date(from: inputDate) ?? Date()
    }
}

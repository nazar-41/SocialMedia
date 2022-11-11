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
    
    func updateGivenPost(id: String){
        guard let postList = postList else{
            print("\n invalid post list")
            return
        }
        
        guard var givenPost = postList.first(where: {$0.id == id}) else{
            print("\n no such post with an ID: \(id)")
            return
        }
        
        
        if !doesPostLiked(postID: id){
            givenPost.likes.append(id)
        }else{
            print("\n post is already liked")
        }
        
        do {
            try self.database.collection("posts").document(givenPost.id).setData(from: givenPost)
        } catch {
            print("\n error updating post: \(error)")
        }
        
        /*
        let path = database.collection("posts").document(givenPost.id).addSnapshotListener { documentSnapshot, error in
            guard error == nil else{
                print("\n error updating post: \(error)")
                return
            }
            
            guard let document = documentSnapshot else{
                print("\n invalid post return type")
                return
            }
        }
         */
    }
    
    func doesPostLiked(postID: String)-> Bool{
        guard let post = postList?.first(where: {$0.id == postID}) else{return false}
        
        return post.likes.first(where: {$0 == postID}) != nil
        
    }
}

//
//  FirebaseManager.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 21/10/2022.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth




class FirebaseManager: ObservableObject{
    
    @Published var users: [ContactModel] = []
    @Published var addSuccess: Bool = false
    @Published var profileImage: UIImage? = nil
    @AppStorage("email") private var email: String = ""
    
    private let database = Firestore.firestore()
    
    @Published var profile_image_url: String = ""
    
    init(){
        getUsersList()
       // downloadProfileImage()
    }
    
    func getUsersList(){
        /*
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
                                        createdDate: self.unwrappedValue(document: document, fieldName: "created_date"),
                                        profile_image: self.unwrappedValue(document: document, fieldName: "profile_image"))
                }
            }
        }
         */
        
        database.collection("users_list").addSnapshotListener {[weak self] querySnapshot, error in
            guard error == nil else{
                print("\n error getting user list")
                return
            }
            
            guard let users = querySnapshot?.documents else{
                print("\n error fetching user list documents")
                return
            }
            
            guard let self = self else{return}
            
            self.users = users.compactMap{ user -> ContactModel? in
                do{
                    return try user.data(as: ContactModel.self)
                }catch{
                    print("\n error decoding user into ContactModel: \(error)")
                    return nil
                }
            }
        }
    }
    
     
    private func unwrappedValue(document: QueryDocumentSnapshot, fieldName: String)-> String{
        return document[fieldName] as? String ?? "-"
    }
        
    /*
    func addUser(user: ContactModel, profileImage: UIImage?){
      //  guard availableImageSize(image: profileImage) == true else{return}

        
        let data: [String: Any] = ["name" : user.name,
                                   "surname" : user.surname,
                                   "username" : user.username,
                                   "email" : user.email,
                                   "mobile" : user.phoneNumber,
                                   "created_date" : user.createdDate,
                                   "profile_image" : profile_image_url]
        
        database.collection(Constants.fb_userslist).addDocument(data: data) { error in
            guard error == nil else{
                print("error adding data: \(String(describing: error))")
                return
            }
            self.uploadImage(image: profileImage)
            
            self.fetchData()
            self.addSuccess = true
        }
    }
     */
    /*
    func addUser(image: UIImage?, user: ContactModel){
        if let image = image {
            guard availableImageSize(image: image) else{return}
            
            guard let data = image.pngData() else{
                print("error converting image to data")
                return}
            
            let storageRef = Storage.storage().reference()
            let profileImagesFolderRef = storageRef.child("profile_images/\(email).png")
            
            profileImagesFolderRef.putData(data, metadata: nil) { metaData, error in
                guard error == nil else{
                    print("\n error uploading image: \(String(describing: error))")
                    return
                }
                guard let metaData = metaData else{
                    print("\n invalid metadata")
                    return
                }
                
                profileImagesFolderRef.downloadURL {[weak self] url, error in
                    guard error == nil else{
                        print("\n error getting profile image download url: \(error)")
                        return
                    }
                    
                    guard let url = url else{ return}
                    guard let self = self else{return}
                    self.profile_image_url = url.absoluteString
                    
                    self.downloadProfileImage()
                    
                    print("\n profile image download url: \(url)")
                    
                    let data: [String: Any] = ["id" : user.id,
                                               "name" : user.name,
                                               "surname" : user.surname,
                                               "username" : user.username,
                                               "email" : self.email,
                                               "mobile" : user.phoneNumber,
                                               "created_date" : user.createdDate,
                                               "profile_image" : self.profile_image_url,
                                               "followers": user.followers,
                                               "following": user.following]
                    
                    self.database.collection(Constants.fb_userslist).addDocument(data: data) { error in
                        guard error == nil else{
                            print("error adding data: \(String(describing: error))")
                            return
                        }
                      //  self.uploadImage(image: profileImage)
                        
                        self.getUsersList()
                        self.addSuccess = true
                    }
                }
            }
        }else{
            let data: [String: Any] = ["id": user.id,
                                       "name" : user.name,
                                       "surname" : user.surname,
                                       "username" : user.username,
                                       "email" : user.email,
                                       "mobile" : user.phoneNumber,
                                       "created_date" : user.createdDate,
                                       "profile_image" : "",
                                       "followers": user.followers,
                                       "following": user.following]
            
            let document = database.collection(Constants.fb_userslist).document(user.id)
            
            database.collection(Constants.fb_userslist).addDocument(data: data) { error in
                guard error == nil else{
                    print("error adding data: \(String(describing: error))")
                    return
                }
               // self.uploadImage(image: profileImage)
                
                self.getUsersList()
                self.addSuccess = true
            }
        }
    }
     */
    
    func addUser2(user: ContactModel, image: UIImage?){
        if let image = image{
            guard let data = image.pngData() else{ return }
            
            let storageRef = Storage.storage().reference()
            let profileImageFolderRef = storageRef.child("profile_images/\(email).png")
            
            profileImageFolderRef.putData(data) { metadata, error in
                guard error == nil else{return}
                
                profileImageFolderRef.downloadURL {[weak self] url, error in
                    guard error == nil,
                          let url = url,
                          let self = self else{ return }
                    
                    self.profile_image_url = url.absoluteString

                    if !self.profile_image_url.isEmpty{
                        
                        var newUser = user
                        newUser.profile_image = self.profile_image_url
                        
                        
                        do {
                            try self.database.collection(Constants.fb_userslist).document(user.id).setData(from: user)
                        } catch {
                            print("\n error creating user: \(error)")
                        }
                        
                    }else{
                        print("\n image url is empty")
                    }
                }
            }
        }else{
            do {
                try database.collection(Constants.fb_userslist).document(user.id).setData(from: user.self)
            } catch {
                print("\n error creating user: \(error)")
            }
        }
    }
    
    /*
     func sharePost2(post: PostModel, environment: Binding<PresentationMode>){
         do {
             try database.collection("posts").document(post.id).setData(from: post)
         } catch {
             print("\n error posting data: \(error)")
         }
         
         
         defer{
             environment.wrappedValue.dismiss()
         }
     }
     */
    
    func downloadProfileImage(){
        let folderReference = Storage.storage().reference()
        let imageReference = folderReference.child("profile_images/\(email).png")
        
        imageReference.getData(maxSize: 5 * 1024 * 1024) {[weak self] data, error in // 5 MB
            guard error == nil else{
                print("\n error downloading image: \(error)")
                return
            }
            
            guard let data = data else{
                print("no data image")
                return
            }
            
            guard let self = self else{return}
            
            self.profileImage = UIImage(data: data)
            
        }
    }
    
    private func availableImageSize(image: UIImage?)-> Bool{
        guard let image = image?.pngData() else{return false}
        
        let sizeInMB = image.count / 1024 / 1024
        
        return sizeInMB <= 2
        
    }
    
    private func removeNotSignedUsers(){
       // let test = Auth.auth().getStoredUser(forAccessGroup: nil)
    }
    
    
}

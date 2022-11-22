//
//  VM_CreateProfile.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 25/10/2022.
//

import SwiftUI
import Combine
import FirebaseStorage
import FirebaseFirestore


class VM_CreateProfile: ObservableObject{
    @Published var contactList: [ContactModel] = []
    @Published var isSuccess: Bool = false
    @Published var profileImage: UIImage? = nil
    
    @AppStorage("email") private var email: String = ""
    @AppStorage("loggedIn") private var loggedIn: Bool = false
    
    private let database = Firestore.firestore()



    
    let firebaseManager = FirebaseManager()
    
    private var cancellables = Set<AnyCancellable>()
    /*
    func registerUser(user: ContactModel){
       // firebaseManager.addUser2(image: profileImage, user: user)
        firebaseManager.addUser2(user: user, image: profileImage)
        
        
        defer{
            firebaseManager.$users
                .sink {[weak self] returnedList in
                    guard let self = self else{return}
                    self.contactList = returnedList
                }
                .store(in: &cancellables)
            
            firebaseManager.$addSuccess
                .sink {[weak self] isSuccess in
                    guard let self = self else {return}
                    self.email = user.email
                   // self.isSuccess = isSuccess
                   // self.loggedIn = true
                    
                }
                .store(in: &cancellables)
            
        }
    }
    */
    /*
    func addUser(user: ContactModel){
        if let image = profileImage {
          //  guard availableImageSize(image: image) else{return}
            
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
                   // self.profile_image_url = url.absoluteString
                    
                    self.downloadProfileImage()
                    
                    print("\n profile image download url: \(url)")
                    
                    let data: [String: Any] = ["name" : user.name,
                                               "surname" : user.surname,
                                               "username" : user.username,
                                               "email" : self.email,
                                               "mobile" : user.phoneNumber,
                                               "created_date" : user.createdDate,
                                               "profile_image" : url.absoluteString]
                    
                    self.database.collection(Constants.fb_userslist).addDocument(data: data) { error in
                        guard error == nil else{
                            print("error adding data: \(String(describing: error))")
                            return
                        }
                      //  self.uploadImage(image: profileImage)
                        self.email = user.email
                       // self.isSuccess = isSuccess
                       // self.loggedIn = true
                        
                        self.firebaseManager.getUsersList()
                        self.isSuccess = true
                        self.loggedIn = true
                    }
                }
            }
        }else{
            let data: [String: Any] = ["name" : user.name,
                                       "surname" : user.surname,
                                       "username" : user.username,
                                       "email" : email,
                                       "mobile" : user.phoneNumber,
                                       "created_date" : user.createdDate,
                                       "profile_image" : ""]
            
            database.collection(Constants.fb_userslist).addDocument(data: data) { error in
                guard error == nil else{
                    print("error adding data: \(String(describing: error))")
                    return
                }
               // self.uploadImage(image: profileImage)
               // self.email = user.email

                self.firebaseManager.getUsersList()
                self.isSuccess = true
                self.loggedIn = true

            }
        }
    }
    */
    
    func addUser2(user: ContactModel){
        if let image = profileImage{
            guard let data = image.pngData() else{ return }
            
            let storageRef = Storage.storage().reference()
            let profileImageFolderRef = storageRef.child("profile_images/\(email).png")
            
            profileImageFolderRef.putData(data) { metadata, error in
                guard error == nil else{return}
                
                profileImageFolderRef.downloadURL {[weak self] url, error in
                    guard error == nil,
                          let url = url,
                          let self = self else{ return }
                    

                    if !url.absoluteString.isEmpty{
                        
                        var newUser = user
                        newUser.profile_image = url.absoluteString
                        
                        
                        do {
                            try self.database.collection(Constants.fb_userslist).document(newUser.id).setData(from: newUser)
                            
                            self.firebaseManager.getUsersList()
                            self.isSuccess = true
                            self.loggedIn = true
                            
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
                
                self.firebaseManager.getUsersList()
                self.isSuccess = true
                self.loggedIn = true
                
            } catch {
                print("\n error creating user: \(error)")
            }
        }
    }

    
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
}

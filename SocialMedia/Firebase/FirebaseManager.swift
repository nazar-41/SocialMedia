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
    
    init(){
        fetchData()
        downloadProfileImage()
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
        
    func addUser(user: ContactModel, profileImage: UIImage?){
      //  guard availableImageSize(image: profileImage) == true else{return}

        
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
            self.uploadImage(image: profileImage)
            
            self.fetchData()
            self.addSuccess = true
        }
    }
    
    func uploadImage(image: UIImage?){
        if let image = image {
            guard availableImageSize(image: image) else{return}
            
            guard let data = image.pngData() else{
                print("error converting image to data")
                return}
            
            let storageRef = Storage.storage().reference()
            let profileImagesFolderRef = storageRef.child("profile_images/\(email).png")
            
            let uploadTask = profileImagesFolderRef.putData(data, metadata: nil) { metaData, error in
                guard error == nil else{
                    print("\n error uploading image: \(error)")
                    return
                }
                guard let metaData = metaData else{
                    print("\n invalid metadata")
                    return
                }
                
                let size = metaData.size
                profileImagesFolderRef.downloadURL { url, error in
                    guard error == nil else{
                        print("\n error getting profile image download url: \(error)")
                        return
                    }
                    
                    guard let url = url else{ return}
                    
                    print("\n profile image download url: \(url)")
                }
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
    
    private func availableImageSize(image: UIImage?)-> Bool{
        guard let image = image?.pngData() else{return false}
        
        let sizeInMB = image.count / 1024 / 1024
        
        return sizeInMB <= 2
        
    }
    
    private func removeNotSignedUsers(){
       // let test = Auth.auth().getStoredUser(forAccessGroup: nil)
    }
    
    
}

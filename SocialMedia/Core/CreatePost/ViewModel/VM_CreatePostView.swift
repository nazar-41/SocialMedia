//
//  VM_CreatePostView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 27/10/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import SwiftUI


class VM_CreatePostView: ObservableObject{
    
    private let database = Firestore.firestore()
    @Published var imageDownloadUrl: String? = nil
    @Published var image: UIImage? = nil

    func sharePost(post: PostModel, environment: Binding<PresentationMode>){
        uploadImage(image: image, post: post)
        
        defer{
            let data: [String : Any] = ["author" : post.author,
                                        "date" : post.date,
                                        "image" : imageDownloadUrl ?? "",
                                        "likes" : post.likes,
                                        "text" : post.text]
            
            
            database.collection("posts").addDocument(data: data) { error in
                guard error == nil else{
                    print("\n error sharing post: \(String(describing: error))")
                    return
                }
                
                environment.wrappedValue.dismiss()
                print("post shared successfully")
            }
        }
    }
    
    
    private func uploadImage(image: UIImage?, post: PostModel){
        if let image = image {
            guard availableImageSize(image: image) else{return}
            
            guard let data = image.pngData() else{
                print("error converting image to data")
                return
            }
            
            let storageRef = Storage.storage().reference()
            let profileImagesFolderRef = storageRef.child("post_images/\(post.id).png")
            
            let uploadTask = profileImagesFolderRef.putData(data, metadata: nil) { metaData, error in
                guard error == nil else{
                    print("\n error uploading image: \(String(describing: error))")
                    return
                }
                guard let metaData = metaData else{
                    print("\n invalid metadata")
                    return
                }
                
                let size = metaData.size
                profileImagesFolderRef.downloadURL { url, error in
                    guard error == nil else{
                        print("\n error getting profile image download url: \(String(describing: error))")
                        return
                    }
                    
                    guard let url = url else{
                        print("url is not returned")
                        return}
                    
                    print("\n profile image download url: \(url)")
                }
            }
        }
    }
    
    private func availableImageSize(image: UIImage?)-> Bool{
        guard let image = image?.pngData() else{return false}
        
        let sizeInMB = image.count / 1024 / 1024
        
        if sizeInMB <= 2 {
            print("image can be uploaded")
        }else{
            print("image size is bigger than 2 mb")
        }
        
        return sizeInMB <= 2
        
    }

}

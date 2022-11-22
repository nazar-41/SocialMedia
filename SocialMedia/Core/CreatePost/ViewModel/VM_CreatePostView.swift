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
    @Published var imageDownloadUrl: String = ""
    @Published var image: UIImage? = nil

    /*
    
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
    
    */
    
    /*
    func sharePost(post: PostModel, environment: Binding<PresentationMode>){
        if let image = image {
            guard availableImageSize(image: image) else{return}
            
            guard let data = image.pngData() else{
                print("error converting image to data")
                return
            }
            
            let storageRef = Storage.storage().reference()
            let profileImagesFolderRef = storageRef.child("post_images/\(post.id).png")
            
            profileImagesFolderRef.putData(data, metadata: nil) { metaData, error in
                guard error == nil else{
                    print("\n error uploading image: \(String(describing: error))")
                    return
                }
                guard let metaData = metaData else{
                    print("\n invalid metadata")
                    return
                }
                
                let size = metaData.size
              //  print("image size: \(size)")
                profileImagesFolderRef.downloadURL {[weak self] url, error in
                    guard error == nil else{
                        print("\n error getting profile image download url: \(String(describing: error))")
                        return
                    }
                    
                    guard let url = url else{
                        print("url is not returned")
                        return}
                    
                   // print("\n \(url.absoluteString)\n")

                    
                    guard let self = self else{return}


                    self.imageDownloadUrl = url.absoluteString

                    let data: [String : Any] = ["author" : post.author,
                                                "date" : post.date,
                                                "image" : url.absoluteString,
                                                "likes" : post.likes,
                                                "text" : post.text]


                    self.database.collection("posts").addDocument(data: data) { error in
                        guard error == nil else{
                            print("\n error sharing post: \(String(describing: error))")
                            return
                        }

                        print("post shared successfully")
                        print("\n post image download url: \(url)")

                    }
                    
                }
            }
            
            
        }else{
            print("image returned nil")
            
            let data: [String : Any] = ["author" : post.author,
                                        "date" : post.date,
                                        "image" : "",
                                        "likes" : post.likes,
                                        "text" : post.text]
            
            
            self.database.collection("posts").addDocument(data: data) { error in
                guard error == nil else{
                    print("\n error sharing post: \(String(describing: error))")
                    return
                }
                
                print("post shared successfully")
            }
        }
    }
    */
    
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
    /*
    private func saveImage2(image: UIImage?, post: PostModel){
        guard let postImage = image,
              let data = postImage.pngData() else{ return }
        
        let storageRef = Storage.storage().reference()
        let postImageFolderRef = storageRef.child("post_images/\(post.id).png")
        
        postImageFolderRef.putData(data) { metadata, error in
            guard error == nil else{return}
            
            postImageFolderRef.downloadURL {[weak self] url, error in
                guard error == nil,
                      let url = url,
                      let self = self else{ return }
                
                self.imageDownloadUrl = url.absoluteString
                print("image posted successfully: \(self.imageDownloadUrl)")
                
            }
        }
    }
    */
    func sharePostWithImage(image: UIImage?, post: PostModel, environment: Binding<PresentationMode>){
     
        guard let postImage = image,
              let data = postImage.pngData() else{ return }
        
        let storageRef = Storage.storage().reference()
        let postImageFolderRef = storageRef.child("post_images/\(post.id).png")
        
        postImageFolderRef.putData(data) { metadata, error in
            guard error == nil else{return}
            
            postImageFolderRef.downloadURL {[weak self] url, error in
                guard error == nil,
                      let url = url,
                      let self = self else{ return }
                
                self.imageDownloadUrl = url.absoluteString
                
                if !self.imageDownloadUrl.isEmpty{
                    
                    let newPost = PostModel(id: post.id,
                                            author: post.author,
                                            text: post.text,
                                            image: url.absoluteString,
                                            date: post.date,
                                            likes: post.likes,
                                            comments: post.comments)
                    
                    self.sharePost2(post: newPost, environment: environment)
                }else{
                    print("\n image url is empty")
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

//
//  VM_PostCardView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 07/11/2022.
//

import SwiftUI
import FirebaseStorage


class VM_PostCardView: ObservableObject{
    @Published var postImage: UIImage? = nil
    
    
    init(post: PostModel){
        downloadPostImage(postId: post.id)
    }
    
    
    func downloadPostImage(postId: String){
        let folderReference = Storage.storage().reference()
        let imageReference = folderReference.child("post_images/\(postId).png")
        
        imageReference.getData(maxSize: 5 * 1024 * 1024) {[weak self] data, error in // 5 MB
            guard error == nil else{
                print("\n error downloading image: \(String(describing: error))")
                return
            }
            
            guard let data = data else{
                print("no data image")
                return
            }
            guard let self = self else{return}
                        
            self.postImage = UIImage(data: data)
            
            imageReference.downloadURL { url, error in
                guard error == nil else{
                    print("error download post image: \(error)")
                    return
                }
                guard url != nil else {
                    print("no post image download url")
                    return
                }
                
                print("post image download url is: \(url)")
            }
            
        }
    }
}

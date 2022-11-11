//
//  PostCommentsSheet.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 11/11/2022.
//

import SwiftUI

struct PostCommentsSheet: View {
    var post: PostModel
    
    @State private var comment: String = ""
    
    @EnvironmentObject private var global_download: GlobalDownload
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .padding()
                }

                Spacer()
            }

            if let comments = post.comments{
                List(comments){comment in
                    VStack(alignment: .leading){
                        Text(global_download.getUserbyId(email: post.author)?.name ?? "")
                            .font(.subheadline)
                        
                        Text(comment.comment)
                            .font(.headline)
                    }
                }
                
            }else{
                Spacer()
            }
            
            HStack(spacing: 0){
                TextField("comment", text: $comment)
                    .padding(10)
                    .padding(.trailing, 20)
                    .overlay(
                        Image(systemName: "xmark")
                            .padding(10)
                            .opacity(comment.isEmpty ? 0 : 1)
                            .onTapGesture {
                                UIApplication.shared.endEditing()
                             //   post.comments["@steve"]  = comment

                                comment = ""
                            }
                        
                        , alignment: .trailing
                    )
                    .disableAutocorrection(true)
                
                Button {
                    global_download.commentGivenPost(id: post.id, comment: comment)
                } label: {
                    Image(systemName: "paperplane")
                        .padding(5)
                }

                
            }
            .font(.subheadline)
            .padding(.horizontal, 5)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray.opacity(0.1))
            )
            .padding(.horizontal, 10)
        }
        .padding(.bottom)
    }
}

struct PostCommentsSheet_Previews: PreviewProvider {
    static var previews: some View {
        PostCommentsSheet(post: dev.postCardModel)
            .environmentObject(GlobalDownload())
    }
}

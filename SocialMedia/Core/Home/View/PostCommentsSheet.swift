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
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "xmark")
                    .font(.headline)
                    .padding()
                
                Spacer()
            }

            
            List(post.comments.sorted(by: >), id: \.key){author, comment in
                VStack(alignment: .leading){
                    Text(author)
                        .font(.subheadline)
                    
                    Text(comment)
                        .font(.headline)
                }
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
                    //more code here
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
    
    private func sendComment(){
    }
}

struct PostCommentsSheet_Previews: PreviewProvider {
    static var previews: some View {
        PostCommentsSheet(post: dev.postCardModel)
    }
}

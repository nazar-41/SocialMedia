//
//  CreatePostView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 23/10/2022.
//

import SwiftUI

struct CreatePostView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @StateObject private var vm_createPostView = VM_CreatePostView()
    
    @AppStorage("email") private var email: String = ""
    
    @State private var postText: String = ""
    
    @State private var showImagePickerSheet: Bool = false
        
    
    let defaultPlaceholder: String = "What do you want to talk about?"
    
    var body: some View {
        VStack(spacing: 0){
            header
            
            
            ScrollView {
                VStack{
                    HStack{
                        Circle()
                            .frame(width: 30)

                        Text("Nazar Velkakayev")
                            .font(.system(size: 14, weight: .semibold))

                        Spacer()
                    }


                    ZStack(alignment: .topLeading){
                        
                        TextEditor(text: $postText)
                            .font(.subheadline)
                            .frame(height: 300)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.5)))
                            .overlay(
                                    Text(postText.isEmpty ? defaultPlaceholder : "")
                                        .font(.subheadline)
                                        .disabled(true)
                                        .padding(10)
                                        .foregroundColor(.gray)
                                    
                                    , alignment: .topLeading
                                )
                        
                    }

                    HStack {
                        Spacer()

                        Button {
                            //more code here
                            showImagePickerSheet = true
                        } label: {
                            HStack{
                                Image(systemName: "photo.fill")
                                Text("Add a photo")
                            }
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .semibold))
                        }
                    }
                    .padding(.top, 10)

                }
                .padding(.horizontal)
                .padding(.top)
                .overlay (
                    Image(uiImage: vm_createPostView.image ?? UIImage())
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 60, height: 60)
                            .padding(.bottom, 30)
                            .padding(.trailing, 10)
                    
                    ,alignment: .bottomTrailing
                )
                
                VStack(alignment: .leading){

                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            
            Spacer()
            
            
        }
        .sheet(isPresented: $showImagePickerSheet, content: {
            ImagePicker(image: $vm_createPostView.image)
        })
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
//        .edgesIgnoringSafeArea(.bottom)
    }
    
}


struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
    }
}


extension CreatePostView{
    @ViewBuilder private var header: some View{
        ZStack(alignment: .top){
            Color(.gray).opacity(0.1)
                .edgesIgnoringSafeArea(.top)
            
            HStack{
                Button {
                    //more code here
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .padding(.vertical, 5)
                        .frame(width: 50)
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("Start post")
                
                Spacer()
                
                Button {
                    //more code here
                    let newPost = PostModel(author: email,
                                            text: postText,
                                            image: "",
                                            date: "\(Date())",
                                            likes: "2")
                    
                    vm_createPostView.sharePost(post: newPost, environment: presentationMode)
                    
                } label: {
                    Text("Post")
                        .padding(.vertical, 5)
                        .frame(width: 50)
                        .foregroundColor(postText.isEmpty ? .gray : .black)
                }
                .disabled(postText.isEmpty)
                
                
            }
            .padding(.horizontal)
            .font(.headline)
            
        }
        .frame(height: 40)
    }
}

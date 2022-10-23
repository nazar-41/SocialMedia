//
//  CreatePostView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 23/10/2022.
//

import SwiftUI

struct CreatePostView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var postText: String = "What do you want to talk about?"
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
                    
                    
                    TextEditor(text: $postText)
                        .font(.subheadline)
                        .frame(height: 300)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.5)))
                    
                    HStack {
                        Spacer()

                        Button {
                            //more code here
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
            }
            
            Spacer()
            
//
//            ZStack(alignment: .top){
//                VStack{
//                    Capsule()
//                        .fill(.white)
//                        .frame(width: 40, height: 7)
//
//                    VStack(alignment: .leading){
//
//
//                       // .frame(maxWidth: .infinity, alignment: .leading)
//
//
//                    }
//                    .padding(.top)
//                    .font(.system(size: 14, weight: .bold))
//
//                    Spacer()
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .padding()
//
//
//            }
//            .frame(height: 300)
//            .background(RoundedRectangle(cornerRadius: 30).fill(.gray.opacity(0.4)))
            
            
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

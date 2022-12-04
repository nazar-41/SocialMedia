//
//  UpdatePostView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 04/12/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct UpdatePostView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var showImagePickerSheet: Bool = false
    
    @State private var image: UIImage?
    
    
    @State var updatePostModel: PostModel

    @EnvironmentObject private var globalDownload: GlobalDownload
    
    
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
                        
                        TextEditor(text: $updatePostModel.text)
                            .font(.subheadline)
                            .frame(height: 300)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.5)))
                            .overlay(
                                    Text(updatePostModel.text.isEmpty ? defaultPlaceholder : "")
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
                    VStack{
                        if let url = URL(string: updatePostModel.image ?? ""){
                            WebImage(url: url)
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 60, height: 60)
                                .padding(.bottom, 30)
                                .padding(.trailing, 10)
                        }else{
                            Image(uiImage: image ?? UIImage())
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 60, height: 60)
                                .padding(.bottom, 30)
                                .padding(.trailing, 10)
                        }
                    }

                    
                    ,alignment: .bottomTrailing
                )
                
                VStack(alignment: .leading){

                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            
            Spacer()
            
            
        }
        .sheet(isPresented: $showImagePickerSheet, content: {
            ImagePicker(image: $image)
        })
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

struct UpdatePostView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePostView(updatePostModel: dev.postCardModel)
    }
}


extension UpdatePostView{
    @ViewBuilder private var header: some View{
        ZStack(alignment: .center){
            Color(.gray).opacity(0.1)
                .edgesIgnoringSafeArea(.top)
            
            HStack(alignment: .center){
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
                
                Text("Update post")
                
                Spacer()
                
                Button {
                    //more code here
                    globalDownload.updatePost(post: updatePostModel, presentationMode: presentationMode)
                    
                } label: {
                    Text("Update")
                        .padding(.vertical, 5)
                        .foregroundColor(updatePostModel.text.isEmpty ? .gray : .black)
                }
                .disabled(updatePostModel.text.isEmpty)
                
                
            }
            .padding(.horizontal)
            .font(.headline)
            
        }
        .frame(height: 50)
    }

}

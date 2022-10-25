//
//  CreateProfile.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 24/10/2022.
//

import SwiftUI
import iPhoneNumberField

struct CreateProfile: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @StateObject private var vm_createProfile = VM_CreateProfile()
    @State private var isSuccess: Bool = false
    
    
    @State private var image: Image? = nil
    
    @State private var showImagePicker: Bool = false
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var userName: String = ""
    @State private var phoneNumber: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink("", destination: ContentView().navigationBarHidden(true), isActive: $vm_createProfile.isSuccess)
                    .hidden()
                HStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .padding(10)
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                    
                    
                    
                    Spacer()
                }
                
                Button {
                    //more code here
                    withAnimation {
                        showImagePicker = true
                    }
                } label: {
                    if let image = image{
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                            .clipShape(Circle())
                        
                    }else{
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                            .foregroundColor(.gray)
                        
                    }
                }
                .padding(.top)
                
                VStack(spacing: 20){
                    
                    listItem(title: "Name", placeholder: "john", bindedTo: $name)
                    listItem(title: "Surname", placeholder: "Doe", bindedTo: $surname)
                    listItem(title: "Username", placeholder: "@johndoe", bindedTo: $userName)
                    
                    HStack{
                        Text("Mobile: ")
                            .frame(width: 100, alignment: .leading)
                        
                        iPhoneNumberField("(000) 000-0000", text: $phoneNumber)
                            .flagHidden(false)
                            .flagSelectable(true)
                            .prefixHidden(true)
                            .padding(5)
                        // .underline()
                    }
                    .overlay(Rectangle().stroke(.gray.opacity(0.4)).frame(height: 0.3), alignment: .bottom)
                    .font(.headline)
                    
                    Button {
                        //more code here
                        //save userData to firebase
                        let contact = ContactModel(id: UUID().uuidString,
                                                   name: name,
                                                   surname: surname,
                                                   username: userName,
                                                   email: "n/a",
                                                   phoneNumber: phoneNumber,
                                                   createdDate: "\(Date.now)")
                        
                        vm_createProfile.registerUser(user: contact)
                        
                    } label: {
                        Text("Start")
                            .frame(maxWidth: UIScreen.main.bounds.width * 0.7, maxHeight: 40)
                            .font(.headline)
                            .foregroundColor(.blue)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.blue))
                        
                    }
                    .padding(.top)
                    
                    
                    
                    
                }
                .padding(.top)
                
                Spacer()
                
                
                
                
            }
            .padding(.horizontal)
            //            .navigationTitle("Profile")
            //            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $image)
            }
            .background{
                Image("asman_logo")
                    .resizable()
                    .scaledToFit()
                    .blur(radius: 15)
                
                
            }
        }
    }
}

struct CreateProfile_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfile()
    }
}


extension CreateProfile{
    //MARK: info list item
    @ViewBuilder private func listItem(title: String, placeholder: String, bindedTo: Binding<String>)-> some View{
        HStack{
            Text("\(title): ")
                .frame(width: 100, alignment: .leading)
            TextField(placeholder, text: bindedTo)
                .padding(5)
            // .underline()
        }
        .overlay(Rectangle().stroke(.gray.opacity(0.4)).frame(height: 0.3), alignment: .bottom)
        .font(.headline)
    }
}

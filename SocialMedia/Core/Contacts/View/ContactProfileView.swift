//
//  ContactProfileView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 20/10/2022.
//

import SwiftUI

struct ContactProfileView: View {
    let contact: ContactModel
    
    @Environment(\.presentationMode) private var presentationMode
    
    @EnvironmentObject private var vm_exploreView: VM_ExploreView
    @EnvironmentObject private var globalDownload: GlobalDownload
    @StateObject private var vm_contactProfileView = VM_ContactProfileView()
    
    var body: some View {
        VStack{
            HStack(spacing: 10){
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                }
                .padding(5)
                
                
                Image(systemName: "bag")
                    .font(.system(size: 13, weight: .heavy))
                
                Text(contact.username)
                    .font(.system(size: 19, weight: .heavy))
                
                Spacer()
                
            }
            
            
            ScrollView(showsIndicators: false) {
                //profile main info
                mainInfo()
                
                VStack{
                    Button {
                        vm_contactProfileView.sendConnction(contactID: contact.id, list: globalDownload.userList, currentUserID: globalDownload.currentUser?.id)
                    } label: {
                        HStack{
                            Text("Follow")
                                
                            Image(systemName: "plus")
                        }
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .frame(height: 30)
                        .frame(maxWidth: .infinity)
                        .background(.blue.opacity(1))
                        .cornerRadius(10)
                    }
                }
                
                if !vm_exploreView.compositionalArray.isEmpty{
                    VStack{
                        ForEach(vm_exploreView.compositionalArray.shuffled().indices, id: \.self){index in
                            E_layout2(exploreImage: vm_exploreView.compositionalArray[index], allPosts: [])
                        }
                    }
                    .padding(.top)
                }else{
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .padding(.top, 200)
                }
            }
            
            
            
            
            Spacer()
            
        }
        .padding()
        // .foregroundColor(.white)
        .accentColor(.black)
        .navigationBarHidden(true)
        
    }
}

struct ContactProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ContactProfileView(contact: dev.contact_1)
            .environmentObject(VM_ExploreView())
    }
}


extension ContactProfileView{
    //MARK: Profile main info
    @ViewBuilder private func mainInfo()-> some View{
        VStack(spacing: 10){
            HStack{
                
                Button {
                    //more code here
                } label: {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .overlay (
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .symbolRenderingMode(.multicolor)
                                .foregroundColor(.blue)
                                .frame(width: 20, height: 20)
                            
                            , alignment: .bottomTrailing
                        )
                }
                
                
                Spacer()
                
                HStack(spacing: 30){
                    VStack(spacing: 5){
                        Text("12")
                        
                        Text("Posts")
                    }
                    .font(.system(size: 14, weight: .bold))
                    
                    VStack(spacing: 5){
                        Text("142")
                        
                        Text("Followers")
                    }
                    .font(.system(size: 14, weight: .bold))
                    
                    VStack(spacing: 5){
                        Text("98")
                        
                        Text("Following")
                    }
                    .font(.system(size: 14, weight: .bold))
                    
                    
                }
                .font(.system(size: 13, weight: .semibold))
                
            }
            .padding(.top)
            
            HStack{
                Text(contact.name)
                    .font(.system(size: 13, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

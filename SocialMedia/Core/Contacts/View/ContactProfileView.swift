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
                
                Button {
                    //more core here
                } label: {
                    HStack{
                        Image(systemName: "bag")
                            .font(.system(size: 13, weight: .heavy))
                        
                        Text(contact.username)
                            .font(.system(size: 19, weight: .heavy))
                    }
                }
                
                
                
                
                Spacer()
                
                Button {
                    //more code here
                } label: {
                    Image(systemName: "plus.square")
                        .font(.system(size: 19, weight: .semibold))
                }
                
                
                Button {
                    //more code here
                } label: {
                    Image(systemName: "text.justify")
                        .font(.system(size: 19, weight: .semibold))
                }
                
                
                
                
            }
            
            
            ScrollView(showsIndicators: false) {
                //profile main info
                mainInfo()
                
                VStack{
                    Button {
                        //
                    } label: {
                        ZStack{
                            Color.gray.opacity(0.15)
                                .cornerRadius(10)
                            
                            Text("Edit profile")
                                .font(.system(size: 14, weight: .bold))
                        }
                        .frame(height: 30)
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

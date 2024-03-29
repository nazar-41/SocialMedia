//
//  ContactsView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 19/10/2022.
//

import SwiftUI

struct ContactsView: View {    
    @StateObject private var vm_contactsView = VM_ContactsView()
    @EnvironmentObject private var vm_exploreView: VM_ExploreView
    @EnvironmentObject private var globalDownload: GlobalDownload
    
    @AppStorage("email") private var currentUserEmail: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Text("Contacts")
                    .font(.headline)
            }
            
            SearchBarView(placeholderText: "elon", searchBarText: $vm_contactsView.searchBarText)
                .padding(.bottom, 5)
            
            List{
                HStack{
                    Circle()
                        .fill(.blue)
                        .frame(width: 40, height: 40)
                    Text("Add new contact")
                    Spacer()
                    Image(systemName: "person.crop.circle.badge.plus")
                }
                .listRowInsets(.init(top: 2, leading: 2, bottom: 2, trailing: 2))
                .contentShape(Rectangle())
                .padding(.vertical, 5)
                .onTapGesture {
                    print("add new contact tapped")
                }
                
                HStack{
                    Circle()
                        .fill(.red)
                        .frame(width: 40, height: 40)
                    Text("Add new post")
                    Spacer()
                    Image(systemName: "plus.circle")
                }
                .listRowInsets(.init(top: 2, leading: 2, bottom: 2, trailing: 2))
                .contentShape(Rectangle())
                .padding(.vertical, 5)
                .onTapGesture {
                    print("add new post tapped")
                }
                
                if let allContacts = vm_contactsView.allContacts{
                    ForEach(allContacts) { contact in
                        if contact.email != currentUserEmail{
                            NavigationLink {
                                ContactProfileView(contact: contact)
                                    .environmentObject(vm_exploreView)
                                    .environmentObject(globalDownload)
                            } label: {
                                ContactRowView(contact: contact)
                                
                            }
                            .listRowInsets(.init(top: 2, leading: 2, bottom: 2, trailing: 2))
                            .contentShape(Rectangle())
                            
                        }
                        
                    }
                }
                
                
            }
            .listStyle(.plain)
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 1)
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactsView()
                .navigationBarHidden(true)
                .environmentObject(VM_ExploreView())
        }
    }
}

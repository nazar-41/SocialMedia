//
//  ContactsView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 19/10/2022.
//

import SwiftUI

struct ContactsView: View {
    let allContacts: [ContactModel]
    
    @StateObject private var vm_contactsView = VM_ContactsView()
    
    var body: some View {
        VStack{
            HStack{
                Text("Contacts")
                    .font(.headline)
            }
            
            SearchBarView(placeholderText: "elon", searchBarText: $vm_contactsView.searchBarText)
            
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
                
                
                ForEach(vm_contactsView.filteredContacts(startingArray: allContacts)) { contact in
                    ContactRowView(contact: contact)
                        .listRowInsets(.init(top: 2, leading: 2, bottom: 2, trailing: 2))
                        .contentShape(Rectangle())
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
        ContactsView(allContacts: [dev.contact_1, dev.contact_2, dev.contact_3])
    }
}

//
//  VM_ChatListView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 23/10/2022.
//

import Foundation


class VM_ChatListView: ObservableObject{
    @Published var searchBarText: String = ""
    
    func filteredContacts(startingArray: [ContactModel])-> [ContactModel]{
         guard !searchBarText.isEmpty else {return startingArray}
         
         let lowercasedText = searchBarText.lowercased()
         
         let filtered = startingArray.filter({$0.name.contains(lowercasedText) || $0.surname.contains(lowercasedText) || $0.username.contains(lowercasedText) || $0.email.contains(lowercasedText) || $0.phoneNumber.contains(lowercasedText)})
         
         
         return filtered
     }
     
}

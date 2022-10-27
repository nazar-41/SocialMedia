//
//  VM_ContactsView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 19/10/2022.
//

import Foundation
import Combine


class VM_ContactsView: ObservableObject{
    @Published var searchBarText: String = ""
    
    @Published var allContacts: [ContactModel] = []
    
    private let firebaseManager = FirebaseManager()
    private var cancellables = Set<AnyCancellable>()
    
    
    init(){
        getAllContacts()
    }
    
    func filteredContacts()-> [ContactModel]{
        guard !searchBarText.isEmpty else {return allContacts}
        
        let lowercasedText = searchBarText.lowercased()
        
        let filtered = allContacts.filter({$0.name.contains(lowercasedText) || $0.surname.contains(lowercasedText) || $0.username.contains(lowercasedText) || $0.email.contains(lowercasedText) || $0.phoneNumber.contains(lowercasedText)})
        
        
        return filtered
    }
    
    private func getAllContacts(){
        firebaseManager.$users
            .sink {[weak self] returnedContacts in
                guard let self = self else {return}
                
                self.allContacts = returnedContacts
            }
            .store(in: &cancellables)
    }
}

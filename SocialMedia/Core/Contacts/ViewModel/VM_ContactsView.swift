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
    
    @Published var allContacts: [ContactModel]? = nil
    
    private let firebaseManager = FirebaseManager()
    private var cancellables = Set<AnyCancellable>()
    
    
    init(){
        addSubscribers()
    }
    
    private func addSubscribers(){
        $searchBarText
            .combineLatest(firebaseManager.$users)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filteredContacts)
            .sink { [weak self] returnedContacts in
                guard let self = self else{return}
                
                self.allContacts = returnedContacts
            }
            .store(in: &cancellables)
    }
    
    
    private func filteredContacts(text: String, startingContacts: [ContactModel])-> [ContactModel]{
         guard !searchBarText.isEmpty else {return startingContacts}

         let lowercasedText = searchBarText.lowercased()

         let filtered = startingContacts.filter({$0.name.contains(lowercasedText) || $0.surname.contains(lowercasedText) || $0.username.contains(lowercasedText) || $0.email.contains(lowercasedText) || $0.phoneNumber.contains(lowercasedText)})


         return filtered
     }
}

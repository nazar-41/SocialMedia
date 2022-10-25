//
//  VM_CreateProfile.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 25/10/2022.
//

import Foundation
import Combine


class VM_CreateProfile: ObservableObject{
    @Published var contactList: [ContactModel] = []
    @Published var isSuccess: Bool = false
    
    let firebaseManager = FirebaseManager()
    
    private var cancellables = Set<AnyCancellable>()
    
    func registerUser(user: ContactModel){
        firebaseManager.addUser(user: user)
        
        defer{
            firebaseManager.$users
                .sink {[weak self] returnedList in
                    guard let self = self else{return}
                    self.contactList = returnedList
                }
                .store(in: &cancellables)
            
            firebaseManager.$addSuccess
                .sink {[weak self] isSuccess in
                    guard let self = self else {return}
                    self.isSuccess = isSuccess
                }
                .store(in: &cancellables)
            
        }
    }
}

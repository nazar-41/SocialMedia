//
//  VM_CreateProfile.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 25/10/2022.
//

import SwiftUI
import Combine


class VM_CreateProfile: ObservableObject{
    @Published var contactList: [ContactModel] = []
    @Published var isSuccess: Bool = false
    @Published var profileImage: UIImage? = nil
    
    @AppStorage("email") private var email: String = ""
    @AppStorage("loggedIn") private var loggedIn: Bool = false


    
    let firebaseManager = FirebaseManager()
    
    private var cancellables = Set<AnyCancellable>()
    
    func registerUser(user: ContactModel){
        firebaseManager.addUser(user: user, profileImage: profileImage)
        
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
                    self.email = user.email
                    self.isSuccess = isSuccess
                    self.loggedIn = true
                    
                }
                .store(in: &cancellables)
            
        }
    }
}

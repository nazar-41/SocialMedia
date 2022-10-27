//
//  VM_ProfileView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 26/10/2022.
//

import SwiftUI
import Combine


class VM_ProfileView: ObservableObject{
    @AppStorage("email") private var email: String = ""
    
    
    private let firebaseManager = FirebaseManager()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userProfile: ContactModel? = nil
    @Published var profileImage: UIImage? = nil
    
    init(){
        getProfileData()
    }
    
    private func getProfileData(){
      //  firebaseManager.fetchData()
        
        firebaseManager.$users
            .sink {[weak self] returnnedList in
                guard let self = self else{return}
                
                if let data = returnnedList.first(where: {$0.email == self.email}){
                    self.userProfile = data
                  //  self.downloadProfileImage()
                }
            }
            .store(in: &cancellables)
        
        firebaseManager.$profileImage
            .sink {[weak self] returnedImage in
                guard let self = self else {return}
                self.profileImage = returnedImage
            }
            .store(in: &cancellables)
        
        
    }
    
//    private func downloadProfileImage(){
//        profileImage = firebaseManager.downloadImage()
//    }
}

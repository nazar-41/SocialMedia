//
//  VM_ExploreView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 17/10/2022.
//

import Combine
import SwiftUI



class VM_ExploreView: ObservableObject{
    @Published var exploreDataArray: [ExploreCardModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let exploreDataService = ExploreViewDataService()
    
    
    init(){
        addSubscribers()
    }
    
    private func addSubscribers(){
        exploreDataService.$exploreData
            .sink { [weak self] returnedModel in
                self?.exploreDataArray = returnedModel
                
                print("\nreturnedModel: \(returnedModel)")
            }
            .store(in: &cancellables)
    }
    
}

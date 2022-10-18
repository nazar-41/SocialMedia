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
    
    @Published var searchBarText: String = ""
    
    @Published var compositionalArray: [[ExploreCardModel]] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let exploreDataService = ExploreViewDataService()
    
    
    init(){
        addSubscribers()
    }
    
    private func addSubscribers(){
        exploreDataService.$exploreData
            .sink { [weak self] returnedModel in
                guard let self = self else {return}
                self.exploreDataArray = returnedModel
                
                self.setCompositionalArray()
                
                }
            .store(in: &cancellables)
    }
    
    private func setCompositionalArray(){
        var currentArrayCards: [ExploreCardModel] = []
        
        exploreDataArray.forEach { card in
            currentArrayCards.append(card)
            
            if currentArrayCards.count == 3{
                compositionalArray.append(currentArrayCards)
                currentArrayCards.removeAll()
            }
            
            // If not 3 or even no of cards
            guard let last = exploreDataArray.last else{return}
            
            if currentArrayCards.count != 3 && card.id == last.id {
                // Append to main array
                compositionalArray.append(currentArrayCards)
                currentArrayCards.removeAll()
            }
        }
        
        
    }
    
}

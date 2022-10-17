//
//  ExploreViewDataService.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 17/10/2022.
//

import Foundation
import Combine


class ExploreViewDataService{
    @Published var exploreData: [ExploreCardModel] = []
    
    var exploreSubscription: AnyCancellable?
    
    init(){
        getExploreData()
    }
    
    
    private func getExploreData(){
        guard let url = URL(string: "https://picsum.photos/v2/list?page=2&limit=100") else{
            print("invalid exploreData url")
            return
        }
        exploreSubscription = NetworkingManger.download(url: url)
            .decode(type: [ExploreCardModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManger.handleComlition, receiveValue: {[weak self] returnedData in
                guard let self = self else {return}
                self.exploreData = returnedData
                self.exploreSubscription?.cancel()
            })
    }
    
}

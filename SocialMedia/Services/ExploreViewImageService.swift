//
//  ExploreViewImageService.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 17/10/2022.
//

import SwiftUI
import Combine


class ExploreViewImageService{
    @Published var image: UIImage?
    
    private var imageSubscription: AnyCancellable?
    private let excplore: ExploreCardModel
    
    init(exploreCard: ExploreCardModel){
        self.excplore = exploreCard
        
        //getImage()
    }
    
    
    private func getImage(){
        guard let url = URL(string: excplore.downloadURL) else{
            print("invalid download image url")
            return
        }
        
        imageSubscription = NetworkingManger.download(url: url)
            .tryMap { (data) -> UIImage? in
                return UIImage(data: data)
            }
            .sink(receiveCompletion: NetworkingManger.handleComlition) {[weak self] returnedImage in
                guard let self = self else{ return}
                                
                self.image = returnedImage
                self.imageSubscription?.cancel()
            }
    }
}

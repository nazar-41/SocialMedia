//
//  VM_ExploreCardImageView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 17/10/2022.
//

import Combine
import SwiftUI

class VM_ExploreCardImageView: ObservableObject{
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    
    private let exploreModel: ExploreCardModel
    private let imageDataService: ExploreViewImageService
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init(exploreModel: ExploreCardModel){
        self.exploreModel = exploreModel
        self.imageDataService = ExploreViewImageService(exploreCard: exploreModel)
        
        self.addImageSubscriber()
        self.isLoading = true
    }
    
    private func addImageSubscriber(){
        imageDataService.$image
            .sink { [weak self] _ in
                guard let self = self else{return}
                self.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                guard let self = self else{return}
                self.image = returnedImage
                
                print("image returned successfully: \(returnedImage?.getSizeIn(.kilobyte))")
            }
            .store(in: &cancellables)

    }
}

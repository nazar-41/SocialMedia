//
//  SwiftUIView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 17/10/2022.
//

import SwiftUI

struct ExploreCardImageView: View {
    @StateObject private var vm_exploreImageView: VM_ExploreCardImageView
    
    init(exploreModel: ExploreCardModel){
        _vm_exploreImageView = StateObject(wrappedValue: VM_ExploreCardImageView(exploreModel: exploreModel))
    }
    
    var body: some View {
        ZStack{
            if let image = vm_exploreImageView.image{
                Image(uiImage: image)
            }else if vm_exploreImageView.isLoading{
                ProgressView()
            }else{
                Image(systemName: "questionmark")
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreCardImageView(exploreModel: dev.exploreCardModel_1)
    }
}

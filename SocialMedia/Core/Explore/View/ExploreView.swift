//
//  ExploreView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 17/10/2022.
//

import SwiftUI

struct ExploreView: View {
    @EnvironmentObject private var vm_exploreView: VM_ExploreView
    
    var body: some View {
        VStack{
            SearchBarView(placeholderText: "Asman", searchBarText: $vm_exploreView.searchBarText)
                .padding(.bottom, 5)
            
            //   Spacer()
            
            if !vm_exploreView.compositionalArray.isEmpty{
                ScrollView{
                    VStack(spacing: 4){
                        ForEach(vm_exploreView.compositionalArray.indices, id: \.self) { index in
                            if index == 0 || index % 6 == 0 {
                                E_layout1(exploreImage: vm_exploreView.compositionalArray[index])
                            } else if index % 3 == 0 {
                                E_layout3(exploreImage: vm_exploreView.compositionalArray[index])
                            } else {
                                E_layout2(exploreImage: vm_exploreView.compositionalArray[index])
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }else{
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .padding(.bottom, 1)
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
         ExploreView()
        //  .environmentObject(VM_ExploreView())
      //  ContentView()
            .environmentObject(VM_ExploreView())
    }
}

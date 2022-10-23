//
//  SearchBarView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 18/10/2022.
//

import SwiftUI

struct SearchBarView: View {
    let placeholderText: String

    @Binding var searchBarText: String
    
    var body: some View {
        HStack(spacing: 0){
            Image(systemName: "magnifyingglass")
            
            TextField(placeholderText, text: $searchBarText)
                .padding(10)
                .padding(.trailing, 10)
                .overlay(
                    Image(systemName: "xmark")
                        .padding(10)
                        .opacity(searchBarText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchBarText = ""
                        }
                    
                    , alignment: .trailing
                )
                .disableAutocorrection(true)
            
        }
        .font(.subheadline)
        .padding(.horizontal, 5)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray.opacity(0.1))
        )
        .padding(.horizontal, 10)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(placeholderText: "Asman", searchBarText: .constant("something here"))
            .previewLayout(.sizeThatFits)
    }
}

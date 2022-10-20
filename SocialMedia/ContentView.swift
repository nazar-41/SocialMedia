//
//  ContentView.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 17/10/2022.
//

import SwiftUI

struct ContentView: View {
    let contactArr = [DeveloperPreview.instance.contact_1,
                      DeveloperPreview.instance.contact_2,
                      DeveloperPreview.instance.contact_3]
    var body: some View {
        TabView{
            tabItemView(view: ChatListView(), icon: "ellipsis.message")
            
            tabItemView(view: ExploreView(), icon: "magnifyingglass")
            
            tabItemView(view: ProfileView(), icon: "person")
            
            tabItemView(view: ContactsView(allContacts: contactArr), icon: "plus.square")


        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(VM_ExploreView())
    }
}

extension ContentView{
    @ViewBuilder private func tabItemView(view: some View, icon: String)-> some View{
        view
            .tabItem {
                Label("", systemImage: icon)
            }
    }
}

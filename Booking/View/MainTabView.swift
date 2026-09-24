//
//  MainTabView.swift
//  Booking
//
//  Created by Zinab Zooba on 17/06/2026.
//

import SwiftUI

        struct MainTabView: View {
            @State private var path = NavigationPath()
            var body: some View {
                if #available(iOS 18.0, *) {
                    TabView {
                     
                            
                        
                        Tab("Home", systemImage: "house") {
                            NavigationStack(path: $path) {
                                HomeView(path: $path)
                            }
                            
                        }
                        Tab("Profile", systemImage: "person") {
                            Profile()
                        }
                    }
                } else {
                    TabView {
                        NavigationStack (path: $path) {
                            
                       
                        HomeView(path: $path)
                            .tabItem {
                                Label("Home", systemImage: "house")
                            }
                        }
                        Profile()
                            .tabItem {
                                Label("Profile", systemImage: "person")
                            }
                    }
                }
            }
        }
    

#Preview{
    MainTabView()
}

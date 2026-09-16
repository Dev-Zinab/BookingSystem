//
//  MainTabView.swift
//  Booking
//
//  Created by Zinab Zooba on 17/06/2026.
//

import SwiftUI

        struct MainTabView: View {
            var body: some View {
                if #available(iOS 18.0, *) {
                    TabView {
                     
                            
                        
                        Tab("Home", systemImage: "house") {
                            NavigationStack {
                                HomeView()
                            }
                            
                        }
                        Tab("Profile", systemImage: "person") {
                            Profile()
                        }
                    }
                } else {
                    TabView {
                        NavigationStack {
                            
                       
                        HomeView()
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

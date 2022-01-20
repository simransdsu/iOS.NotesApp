//
//  HomeView.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-08.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        Text("Hello \(homeViewModel.userName)")
            .onAppear {
                Task {
                    await homeViewModel.getUserInfo()
                }
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

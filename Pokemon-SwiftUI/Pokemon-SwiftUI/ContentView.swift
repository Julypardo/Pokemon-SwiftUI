//
//  ContentView.swift
//  Pokemon-SwiftUI
//
//  Created by July on 2/08/21.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UINavigationBar.appearance().isUserInteractionEnabled = false
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = .clear
    }
    
    var body: some View {
        
        NavigationView {
            SelectionPokemon()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

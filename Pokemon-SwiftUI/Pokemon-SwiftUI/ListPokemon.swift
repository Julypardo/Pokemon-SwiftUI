//
//  ListPokemon.swift
//  Pokemon-SwiftUI
//
//  Created by July on 3/08/21.
//

import SwiftUI

struct ListPokemon: View {
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    Image("pokemonBorder")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 110, height: 110)
                }
                Spacer()
            }
            VStack(alignment: .leading){
                
                HStack {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Spacer()
                }
                .foregroundColor(Color("707070"))
                
                Text("Pokedex")
                    .font(.title)
                    .foregroundColor(Color("707070"))
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                ScrollView(showsIndicators: false) {
                    List()
                        .padding(.bottom, 50)
                }
                .padding(.top, 20)
            }
            .padding(.horizontal, 30)
        }
        .foregroundColor(Color("707070"))
        
    }
}

struct ListPokemon_Previews: PreviewProvider {
    static var previews: some View {
        ListPokemon()
    }
}

struct item: Identifiable {
    var id = UUID()
    var name: String
    var types: String
    var imagePokemon: String
}

struct List: View {
    
    let data: [item] = [
        item(name: "Name", types: "Types", imagePokemon: "pokemon4"),
        item(name: "Name", types: "Types", imagePokemon: "pokemon3"),
        item( name: "Name", types: "Types", imagePokemon: "pokemon2"),
        item( name: "Name", types: "Types", imagePokemon: "pokemon1"),
    ]
    
    var body: some View {
        ForEach (data) { item in
            
            VStack(spacing: 0) {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.white, Color("C1F1FF")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                    
                    HStack {
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text(item.name)
                                .font(.title)
                                .foregroundColor(Color("707070"))
                                .fontWeight(.bold)
                            Text(item.types)
                                .font(.body)
                                .foregroundColor(Color("707070"))
                                .fontWeight(.bold)
                        }
                        Spacer()
                        
                        Image(item.imagePokemon)
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 133, height: 133)
                    }
                    .padding(.horizontal, 10)
                }
                .cornerRadius(20)
                .frame(height: 150)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.07)), radius: 5)
                .padding(5)
            }
        }
    }
}






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
                    .font(.custom("Gilroy-Bold", size: 30))
                    .padding(.top, 40)
                
                ScrollView {
                    List()
                        .padding(.bottom, 50)
                }
                .padding(.top, 20)
            }
            .padding(.horizontal, 15)
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
    var color: String
    var name: String
    var types: String
    var imagePokemon: String
}

struct List: View {
    
    let data: [item] = [
        item(color: "FCD7FB", name: "Name", types: "Types", imagePokemon: "pokemon4"),
        item(color: "FFE0AD", name: "Name", types: "Types", imagePokemon: "pokemon3"),
        item(color: "F5EC77", name: "Name", types: "Types", imagePokemon: "pokemon2"),
        item(color: "C1F1FF", name: "Name", types: "Types", imagePokemon: "pokemon1"),
    ]
    
    var body: some View {
        ForEach (data) { item in
            
            VStack(spacing: 30) {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.white, Color(item.color)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                    
                    HStack {
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text(item.name)
                                .font(.custom("Gilroy-Bold", size: 30))
                            Text(item.types)
                                .font(.custom("Gilroy-Bold", size: 18))
                        }
                        Spacer()
                        
                        Image(item.imagePokemon)
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 133, height: 133)
                    }
                    .padding(15)
                }
                .cornerRadius(20)
                .frame(height: 150)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1219618842)), radius: 5)
                .padding(.top, 30)
            }
        }
    }
}






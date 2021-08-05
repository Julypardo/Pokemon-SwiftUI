//
//  ListPokemon.swift
//  Pokemon-SwiftUI
//
//  Created by July on 3/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ListPokemon: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var viewModel = ListPokemonViewModel()
    
    var body: some View {
        
        ZStack {
            Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    
                    Spacer()
                }
                .foregroundColor(Color("707070"))
                
                Text("Pokedex")
                    .font(.title)
                    .foregroundColor(Color("707070"))
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                
                if #available(iOS 14.0, *) {
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ListCatchPokemon(viewModel: self.viewModel)
                        }
                    }
                    .padding(.top, 20)
                } else {
                    // Fallback on earlier versions
                }
            }
            .padding(.horizontal, 30)
        }
        .foregroundColor(Color("707070"))
        .navigationBarHidden(true)
        .onAppear {
            if self.viewModel.pokemons.isEmpty {
                self.viewModel.getCaughtPokemons()
            }
        }
    }
}

struct ListPokemon_Previews: PreviewProvider {
    static var previews: some View {
        ListPokemon()
    }
}

struct ListCatchPokemon: View {
    
    @ObservedObject var viewModel: ListPokemonViewModel
    
    @State var activePokemon: CatchPokemon?
    @State var cardIsActive = false
    
    var body: some View {
        
        ForEach(Array(self.viewModel.pokemons.enumerated()), id: \.element) { index, element in
            VStack(spacing: 0) {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.white, Color("C1F1FF")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(element.name.capitalizingFirstLetter())
                                .font(.title)
                                .foregroundColor(Color("707070"))
                                .fontWeight(.bold)
                            
                            Text(element.types)
                                .font(.body)
                                .foregroundColor(Color("707070"))
                                .fontWeight(.bold)
                        }
                        
                        Spacer()
                        
                        WebImage(url: URL(string: element.image))
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
            .onTapGesture {
                self.activePokemon = element
                self.cardIsActive = true
            }
            
            if self.activePokemon != nil {
                NavigationLink(destination: CardPokemon(pokemon: .constant(nil),
                                                        pokemonCatch: .constant(element)),
                               isActive: self.$cardIsActive,
                               label: EmptyView.init)
            }
        }
    }
}

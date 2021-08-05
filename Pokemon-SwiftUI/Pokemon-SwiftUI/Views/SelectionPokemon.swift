//
//  PokemonSelection.swift
//  Pokemon-SwiftUI
//
//  Created by July on 3/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SelectionPokemon: View {
    
    @ObservedObject var viewModel = PokemonCardViewModel()
        
    @State var activePokemon: Pokemon?
    @State var cardIsActive = false
    
    var body: some View {
        
        ZStack {
            Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                .edgesIgnoringSafeArea(.all)
           
            VStack{
                ZStack {
                    HStack {
                        Spacer()
                        
                        Text("Pokedex")
                            .font(.title)
                            .foregroundColor(Color("707070"))
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding(.top, 10)
                    
                    HStack {
                        Image("people")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 50, height: 50)
                        
                        Spacer()
                        
                        NavigationLink(destination: ListPokemon()){
                            Image(systemName: "list.bullet")
                                .resizable()
                                .frame(width: 23, height: 20)
                        }
                    }
                    .padding(.horizontal, 30)
                }
                
                Spacer()
                
                
                ZStack {
                    if self.viewModel.position == self.viewModel.pokemonInfo.count - 10 || self.viewModel.position == -1 {
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                            .onAppear {
                                self.viewModel.getPokemonList()
                            }
                    }
                    
                    if self.viewModel.pokemonInfo.count > 0 {
                        ForEach(self.viewModel.pokemonInfo.indices, id: \.self) { i in
                            Card(pokemon: self.viewModel.pokemonInfo[i])
                                .frame(height: UIScreen.main.bounds.height * 0.6)
                                .offset(x: self.viewModel.x[i])
                                .rotationEffect(.init(degrees: self.viewModel.degree[i]))
                                .gesture(DragGesture().onChanged({ (value) in
                                    self.viewModel.discardGesture(value: value, index: i)
                                })
                                .onEnded({ (value) in
                                    self.viewModel.dragEnded(value: value, index: i)
                                }))
                                .onTapGesture {
                                    self.activePokemon = self.viewModel.pokemonInfo[i]
                                    self.cardIsActive = true
                                }
                            
                            if activePokemon != nil {
                                NavigationLink(destination: CardPokemon(pokemon: self.$viewModel.pokemonInfo[self.viewModel.position],
                                                                        pokemonCatch: .constant(nil)),
                                               isActive: self.$cardIsActive,
                                               label: EmptyView.init)
                            }
                        }
                        .padding(.horizontal, 30)
                        .animation(.default)
                    }
                }
                
                Spacer()
                
                HStack(spacing: 40) {
                    Button(action: {
                        self.viewModel.rejectPokemon()
                    }) {
                        Image(uiImage: UIImage(named: "closet")!)
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1219618842)), radius: 5)
                    }
                    
                    Button(action: {
                        self.viewModel.catchPokemon()
                    }) {
                        Image(uiImage: UIImage(named: "accept")!)
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1219618842)), radius: 5)
                    }
                }
                
                Spacer()
            }
        }
        .foregroundColor(Color("707070"))
        .navigationBarHidden(true)
    }
}

struct PokemonSelection_Previews: PreviewProvider {
    static var previews: some View {
        SelectionPokemon()
    }
}

struct Card : View {
    
    var pokemon: Pokemon?
    
    var body :  some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("7CB8DE"), Color(#colorLiteral(red: 0.9386602009, green: 0.9555124231, blue: 0.9482963104, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(height: UIScreen.main.bounds.height * 0.6)
                .cornerRadius(20)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.05636414792)), radius: 7)
            
            WebImage(url: URL(string: self.pokemon?.sprites?.other?.officialArtwork?.frontDefault ?? ""))
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width - 60)
            
            VStack {
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("\(self.pokemon!.name!.capitalizingFirstLetter())")
                            .font(.title)
                            .foregroundColor(Color("707070"))
                            .fontWeight(.bold)
                        
                        if self.pokemon?.types != nil {
                            HStack {
                                ForEach(self.pokemon!.types!, id: \.self) { item in
                                    Text("\(item.type?.name ?? "")")
                                        .font(.body)
                                        .foregroundColor(Color("707070"))
                                        .fontWeight(.bold)
                                }
                            }
                        }
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                }
                .frame(height: 95)
                .background(RoundedCorners(color:Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),tl: 20, tr: 0, bl: 20, br: 0).opacity(0.5))
                .padding(.leading, 40)
                .padding(.bottom, 30)
            }
        }
    }
}

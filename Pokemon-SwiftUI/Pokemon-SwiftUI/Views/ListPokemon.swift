//
//  ListPokemon.swift
//  Pokemon-SwiftUI
//
//  Created by July on 3/08/21.
//

import SDWebImageSwiftUI
import SwiftUI

struct ListPokemon: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject var viewModel = ListPokemonViewModel()
    @State private var tappedItem: CatchPokemon?

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
                .padding(.top, 30)

                Text("Pokedex")
                    .font(.title)
                    .foregroundColor(Color("707070"))
                    .fontWeight(.bold)
                    .padding(.top, 40)

                if #available(iOS 14.0, *) {
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(self.viewModel.pokemons, id: \.id) { element in
                                NavigationLink(destination: CardPokemon(pokemon: .constant(nil), pokemonCatch: .constant(element))) {
                                    CardCatchPokemon(pokemon: element)
                                }
                            }
                        }
                    }
                    .padding(.top, 20)
                } else {
                    List {
                        ForEach(self.viewModel.pokemons, id: \.id) { element in
                            ZStack {
                                NavigationLink(destination: CardPokemon(pokemon: .constant(nil), pokemonCatch: .constant(element))) {
                                    EmptyView()
                                }
                                .hidden()

                                CardCatchPokemon(pokemon: element)
                            }
                            .listRowInsets(EdgeInsets())
                        }
                    }
                    .padding(.top, 20)
                    .onAppear {
                        UITableView.appearance().showsVerticalScrollIndicator = false
                        UITableView.appearance().backgroundColor = UIColor.clear
                        UITableViewCell.appearance().backgroundColor = UIColor.clear
                        UITableView.appearance().separatorStyle = .none
                    }
                }
            }
            .padding(.horizontal, 30)
        }
        .foregroundColor(Color("707070"))
        .navigationBarTitle("")
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

struct CardCatchPokemon: View {
    var pokemon: CatchPokemon
    var text: CGFloat = UIScreen.main.bounds.height <= 726 ? 18 : 25
    var textBody: CGFloat = UIScreen.main.bounds.height <= 726 ? 16 : 18
    var image: CGFloat = UIScreen.main.bounds.height <= 726 ? 90 : 133

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                // LinearGradient(gradient: Gradient(colors: [Color.white, Color("C1F1FF")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 0.8204735762)), Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 0.8105205005)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)

                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(self.pokemon.name.capitalizingFirstLetter())
                            .font(.system(size: text, weight: .bold, design: .default))
                            .foregroundColor(Color.white)

                        Text(self.pokemon.types)
                            .font(.system(size: textBody, weight: .medium, design: .default))
                            .foregroundColor(Color.white)
                    }

                    Spacer()

                    WebImage(url: URL(string: self.pokemon.image))
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: image, height: image)
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

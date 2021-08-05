//
//  PokemonSelection.swift
//  Pokemon-SwiftUI
//
//  Created by July on 3/08/21.
//

import SwiftUI

struct SelectionPokemon: View {
    
    @State var x : [CGFloat] = [0,0,0,0,0,0,0]
    @State var degree : [Double] = [0,0,0,0,0,0,0]
    @State var position : Int = 6
    @State private var animateStrokeStart = false
    @State private var animateStrokeEnd = true
    @State private var isRotating = true
    
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
                    ForEach(0..<7,id: \.self) { i in
                        NavigationLink(destination: CardPokemon()) {
                            Card()
                                .offset(x: self.x[i])
                                .rotationEffect(.init(degrees: self.degree[i]))
                                .gesture(DragGesture().onChanged({ (value) in
                                    if value.translation.width > 0{
                                        self.x[i] = value.translation.width
                                        self.degree[i] = 8
                                    } else {
                                        self.x[i] = value.translation.width
                                        self.degree[i] = -8
                                    }
                                })
                                .onEnded({ (value) in
                                    if value.translation.width > 0 {
                                        if value.translation.width > 100 {
                                            self.x[i] = 500
                                            self.degree[i] = 15
                                            self.position = position - 1
                                        } else {
                                            self.x[i] = 0
                                            self.degree[i] = 0
                                        }
                                    } else {
                                        if value.translation.width < -100 {
                                            self.x[i] = -500
                                            self.degree[i] = -15
                                            self.position = position - 1
                                        } else {
                                            self.x[i] = 0
                                            self.degree[i] = 0
                                        }
                                    }
                                }))
                        }
                    }
                    .padding(.horizontal, 30)
                    .animation(.default)
                }
                
                Spacer()
                
                HStack(spacing: 40) {
                    Button(action: {
                        if self.position >= 0 {
                            self.x[position] = -500
                            self.degree[position] = -15
                        }
                        self.position = position - 1
                    }) {
                        Image(uiImage: UIImage(named: "closet")!)
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1219618842)), radius: 5)
                    }
                    
                    Button(action: {
                        if self.position >= 0 {
                            self.x[position] = 500
                            self.degree[position] = 15
                        }
                        self.position = position - 1
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
    
    var body :  some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("7CB8DE"), Color(#colorLiteral(red: 0.9386602009, green: 0.9555124231, blue: 0.9482963104, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(height: UIScreen.main.bounds.height * 0.6)
                .cornerRadius(20)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.05636414792)), radius: 7)
            
            Image("pokemon1")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width - 60)
            
            VStack {
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Name")
                            .font(.title)
                            .foregroundColor(Color("707070"))
                            .fontWeight(.bold)
                        
                        Text("Types")
                            .font(.body)
                            .foregroundColor(Color("707070"))
                            .fontWeight(.bold)
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                }
                .frame(height: 95)
                .background(RoundedCorners(color:Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),tl: 20, tr: 0, bl: 20, br: 0).opacity(0.5))
                .padding(.leading, 40)
                .padding(.bottom, 30)
            }
            .frame(height: UIScreen.main.bounds.height * 0.6)
        }
    }
}

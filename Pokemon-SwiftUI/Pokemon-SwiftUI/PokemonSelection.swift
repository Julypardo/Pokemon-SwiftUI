//
//  PokemonSelection.swift
//  Pokemon-SwiftUI
//
//  Created by July on 3/08/21.
//

import SwiftUI

struct PokemonSelection: View {
    
    @State var x : [CGFloat] = [0,0,0,0,0,0,0]
    @State var degree : [Double] = [0,0,0,0,0,0,0]
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9843137255, alpha: 1))
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
            .padding(.top, -30)
            
            VStack {
                HStack {
                    Spacer()
                    Text("Pokedex")
                        .font(.title)
                        .foregroundColor(Color("707070"))
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                Spacer()
            }
            
            VStack {
                HStack {
                    Image("people")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 50, height: 50)
                    Spacer()
                    
                    Image(systemName: "list.bullet")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                Spacer()
            }
            .padding(.horizontal, 30)
            
            VStack{
//                Button(action: {
//
//                    for i in 0..<self.x.count{
//
//                        self.x[i] = 0
//                    }
//
//                    for i in 0..<self.degree.count{
//
//                        self.degree[i] = 0
//                    }
//
//                }) {
//
//                    Image(systemName: "return").font(.title)
//                }
                
                ZStack {
                    ForEach(0..<7,id: \.self) { i in
                        Card()
                            .offset(x: self.x[i])
                            .rotationEffect(.init(degrees: self.degree[i]))
                            .gesture(DragGesture()
                                        .onChanged({ (value) in
                                            
                                            if value.translation.width > 0{
                                                self.x[i] = value.translation.width
                                                self.degree[i] = 8
                                            }
                                            else {
                                                self.x[i] = value.translation.width
                                                self.degree[i] = -8
                                            }
                                            
                                        })
                                        .onEnded({ (value) in
                                            
                                            if value.translation.width > 0{
                                                
                                                if value.translation.width > 90 {
                                                    self.x[i] = 500
                                                    self.degree[i] = 15
                                                }
                                                else{
                                                    self.x[i] = 0
                                                    self.degree[i] = 0
                                                }
                                            }
                                            else {
                                                if value.translation.width > -90 {
                                                    self.x[i] = -500
                                                    self.degree[i] = -15
                                                }
                                                else{
                                                    self.x[i] = 0
                                                    self.degree[i] = 0
                                                }
                                            }
                                        }))
                    }
                    .padding()
                    .animation(.default)
                }
               
                
                HStack(spacing: 40){
                    Image("closet")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 65, height: 65)
                        
                    
                    Image("accept")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 65, height: 65)
                }
                .padding(.top, 30)
            }
            
        }
        .foregroundColor(Color("707070"))
    }
}

struct PokemonSelection_Previews: PreviewProvider {
    static var previews: some View {
        PokemonSelection()
    }
}
struct Card : View {
    
    var body :  some View {
        
        ZStack(alignment: .bottomLeading){
            
            LinearGradient(gradient: Gradient(colors: [Color("7CB8DE"), Color(#colorLiteral(red: 0.9386602009, green: 0.9555124231, blue: 0.9482963104, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .cornerRadius(20)
            
            VStack{
                Spacer()
                
                Image("pokemon1")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 410)
                
                Spacer()
            }
            
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
        .frame( height: 557)
    }
}

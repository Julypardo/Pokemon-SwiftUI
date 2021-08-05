//
//  PokemonSelection.swift
//  Pokemon-SwiftUI
//
//  Created by July on 3/08/21.
//

import SwiftUI

struct CardPokemon: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var likeHeart: Bool = true
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("7CB8DE"), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.likeHeart.toggle()
                    }) {
                        Image(systemName: self.likeHeart ? "heart" : "heart.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 23, height: 20)
                    }
                }
                .foregroundColor(Color.white)
                .padding(.all, 30)
                
                if UIScreen.main.bounds.height <= 736 {
                    ScrollView {
                        InfoCard()
                    }
                } else {
                    InfoCard()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct CardPokemon_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CardPokemon()
        }
    }
}

struct InfoCard: View {
    
    var body: some View {
        
        VStack(spacing: 0) {
            InfPokemon()
            
            Spacer()
            
            ZStack {
                VStack {
                    Text(" ")
                        .padding(20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedCorners(color:Color("F2F8FF"),tl: 30, tr: 30, bl: 0, br: 0))
                .offset(x: 0, y: 130)
                
                Image("pokemon1")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 325, height: 325)
            }
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("About")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Divider()
                        .frame(width: 285, height: 2)
                        .background(Color("1791E7"))
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Species")
                                .font(.body)
                                .fontWeight(.regular)
                            
                            Text("Height")
                                .font(.body)
                                .fontWeight(.regular)
                            
                            Text("Weight")
                                .font(.body)
                                .fontWeight(.regular)
                            
                            Text("Abilities")
                                .font(.body)
                                .fontWeight(.regular)
                            
                            Text("Egg Groups")
                                .font(.body)
                                .fontWeight(.regular)
                            
                            Text("Egg Cycle")
                                .font(.body)
                                .fontWeight(.regular)
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Seed")
                                .font(.body)
                                .fontWeight(.regular)
                            
                            Text("2’3’6 (0.70 cm)")
                                .font(.body)
                                .fontWeight(.regular)
                            
                            Text("15.2 lbs (6.9 kg)")
                                .font(.body)
                                .fontWeight(.regular)
                            
                            Text("Overgrow, Chlorophyl")
                                .font(.body)
                                .fontWeight(.regular)
                            
                            Text("Monster")
                                .font(.body)
                                .fontWeight(.regular)
                            
                            Text("Grass")
                                .font(.body)
                                .fontWeight(.regular)
                        }
                        .padding(.leading, 30)
                    }
                    .padding(.top, 20)
                    .font(.custom("Gilroy-Bold", size: 18))
                    
                    Spacer()
                }
                .foregroundColor(Color("707070"))
                .padding(.leading, 20)
                .padding(.top, 10)
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedCorners(color: Color("F2F8FF"), tl: 0, tr: 0, bl: 30, br: 0))
                .edgesIgnoringSafeArea(.all)
                .padding(.top, -5)
            }
            .padding(.bottom, 50)
            .background(Color.white)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        
        GeometryReader { geometry in
            Path { path in
                let w = geometry.size.width
                let h = geometry.size.height
                
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(self.color)
        }
    }
}


struct InfPokemon: View {
    
    var body: some View {
        
        HStack {
            ZStack {
                VStack(alignment: .leading) {
                    Text("Name")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 0) {
                        Text("Types")
                            .font(.body)
                            .fontWeight(.regular)
                        
                        Spacer()
                        
                        Text("0033")
                            .font(.body)
                            .fontWeight(.regular)
                    }
                    .padding(.trailing, 10)
                    .padding(.top, 10)
                }
                .padding(.leading, 30)
                .foregroundColor(.white)
            }
            .frame(width: 226, height: 92)
            .background(RoundedCorners(color:Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2006193249)),tl: 0, tr: 20, bl: 0, br: 20).opacity(0.5))
            
            Spacer()
        }
    }
}
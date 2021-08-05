//
//  PokemonSelection.swift
//  Pokemon-SwiftUI
//
//  Created by July on 3/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardPokemon: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var pokemon: Pokemon?
    @Binding var pokemonCatch: CatchPokemon?
    
    @State var likeHeart: Bool = true
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)), Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 0.8105205005)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
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
                
                ScrollView(showsIndicators: false) {
                    InfoCard(pokemon: self.$pokemon, pokemonCatch: self.$pokemonCatch)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct CardPokemon_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CardPokemon(pokemon: .constant(nil), pokemonCatch: .constant(nil))
        }
    }
}

struct InfPokemon: View {
    
    @Binding var pokemon: Pokemon?
    @Binding var pokemonCatch: CatchPokemon?
    
    var body: some View {
        
        HStack {
            ZStack {
                VStack(alignment: .leading) {
                    Text("\(self.pokemon?.name ?? self.pokemonCatch?.name ?? "")")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 0) {
                        if self.pokemon?.types != nil {
                            HStack {
                                ForEach(self.pokemon!.types!, id: \.self) { item in
                                    Text("\(item.type?.name ?? "")")
                                        .font(.body)
                                        .fontWeight(.regular)
                                }
                            }
                        } else {
                            Text("\(self.pokemonCatch?.types ?? "")")
                                .font(.body)
                                .fontWeight(.regular)
                        }
                        
                        Spacer()
                        
                        Text("#\(self.pokemon?.id ?? self.pokemonCatch?.id ?? 0)")
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


struct InfoCard: View {
    
    @Binding var pokemon: Pokemon?
    @Binding var pokemonCatch: CatchPokemon?
    
    var body: some View {
        
        VStack(spacing: 0) {
            InfPokemon(pokemon: self.$pokemon, pokemonCatch: self.$pokemonCatch)
            
            Spacer()
            
            ZStack {
                VStack {
                    Text(" ")
                        .padding(20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedCorners(color: Color(#colorLiteral(red: 0.9019607843, green: 0.9568627451, blue: 0.9725490196, alpha: 1)),tl: 30, tr: 30, bl: 0, br: 0))
                .offset(x: 0, y: 130)
                
                WebImage(url: URL(string: self.pokemon?.sprites?.other?.officialArtwork?.frontDefault ?? self.pokemonCatch?.image ?? ""))
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
                        .frame(width: 285, height: 1)
                        .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack{
                            Text("Species")
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                            Text("\(self.pokemon?.species?.name ?? self.pokemonCatch?.species ?? "")")
                                .font(.system(size: 18, weight: .regular, design: .default))
                               // .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                                .padding(.leading, 9)
                        }
                        
                        HStack{
                        Text("Height")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                        Text("\((self.pokemon?.height ?? self.pokemonCatch?.height ?? 0 / 10)) Meters")
                            .font(.system(size: 18, weight: .regular, design: .default))
                           // .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                            .padding(.leading, 18)
                    }
                        
                        HStack{
                        Text("Weight")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                        Text("\((self.pokemon?.weight ?? self.pokemonCatch?.weight ?? 0 / 10)) Kilograms")
                            .font(.system(size: 18, weight: .regular, design: .default))
                            //.foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                            .padding(.leading, 16)
                    }
                        Divider()
                            .frame(width: 285, height: 1)
                            .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                            .padding(.vertical, 15)
                        
                        Text("Abilities")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                        
                        if self.pokemon?.abilities != nil {
                            HStack {
                                ForEach(self.pokemon!.abilities!, id: \.self) { item in
                                    Text("\(item.ability?.name ?? "")")
                                        .font(.system(size: 18, weight: .regular, design: .default))
                               }
                            }
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        } else {
                            Text("\(self.pokemonCatch?.abilities ?? "")")
                                .font(.system(size: 18, weight: .regular, design: .default))
                        }
                        
                        Text("Moves")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                        if self.pokemon?.moves != nil {
                            VStack(alignment: .leading){
                                if self.pokemon!.moves!.count > 9 {
                                    ForEach(0..<10, id: \.self) { item in
                                        Text("\(self.pokemon!.moves![item].move?.name ?? "")")
                                            .font(.system(size: 18, weight: .regular, design: .default))
                                            .padding(.trailing, 30)
                                    }
                                } else {
                                    ForEach(0..<self.pokemon!.moves!.count, id: \.self) { item in
                                        Text("\(self.pokemon!.moves![item].move?.name ?? "")")
                                            .font(.system(size: 18, weight: .regular, design: .default))
                                            .padding(.trailing, 30)
                                    }
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        } else {
                            Text("\(self.pokemonCatch?.moves ?? "")")
                                .font(.system(size: 18, weight: .regular, design: .default))
                                .padding(.trailing, 30)
                        }
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .foregroundColor(Color("707070"))
                .padding(.leading, 30)
              
                .padding(.top, 10)
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedCorners(color: Color(#colorLiteral(red: 0.9019607843, green: 0.9568627451, blue: 0.9725490196, alpha: 1)), tl: 0, tr: 0, bl: 60, br: 0))
                .edgesIgnoringSafeArea(.all)
                .padding(.top, -5)
            }
            .padding(.bottom, 50)
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            
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

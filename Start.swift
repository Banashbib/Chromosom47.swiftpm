//
//  Start.swift
//  Chromosom47
//
//  Created by Bana Alshabib on 02/08/1445 AH.
//
import SwiftUI
import AVKit

struct Start: View {
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                   Spacer()
                    Text("Chromosom47")
                        .font(.custom("Impact", fixedSize: 100))
                        .foregroundColor(.black)
                        .padding()
                    Spacer()
                    NavigationLink(destination: PlayingTips()) {
                        HStack{
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 50))
                            Text("Paly")
                                .font(.largeTitle)
                                .bold()
                            
                        }
                        .foregroundColor(.black)
                        .frame(width: 250, height: 100)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.25), radius:12, x: 0, y: 4)
                    }
                  
                    .padding()
                    Spacer()
                    HStack{
                        Spacer()
                        Image("DSKids")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Spacer()
                    }
                }
            }
            .background(Color("Beige"))
        }
        .accentColor(.black)
    }
}

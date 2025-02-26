//
//  PlayingTips.swift
//  Chromosom47
//
//  Created by Bana Alshabib on 15/08/1445 AH.
//

import SwiftUI

struct PlayingTips: View {
    @State private var step = 1
    @State private var navigateToNextView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Beige").edgesIgnoringSafeArea(.all)
                VStack {
                    Text("How To Play?")
                        .font(.custom("Impact", fixedSize: 70))
                        .foregroundColor(.black)
                        .bold()
                    
                    
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white)
                        .frame(width: 697, height: 326)
                        .shadow(radius: 12)
                        .overlay(
                            Group {
                                if step == 1 {
                                    HowToPlayContent(imageName: "Tip1", text: "Press on the Play icon so you can understand what School means...")
                                        .foregroundColor(.black)
                                } else if step == 2 {
                                    HowToPlayContent(imageName: "Tip2", text: "Listen to each item and match it to the category!")
                                        .foregroundColor(.black)
                                } else if step == 3 {
                                    HowToPlayContent(imageName: "Tip3", text: "Check your Answers by clicking on Check button!")
                                        .foregroundColor(.black)
                                }
                                
                                HStack {
                                    Spacer()
                                    VStack {
                                        Spacer()
                                        
                                        NavigationLink(destination: Categories(), isActive: $navigateToNextView) {
                                            EmptyView()
                                        }
                                        
                                        Button(action: {
                                            if step < 3 {
                                                step += 1
                                            } else {
                                                // Navigate to another view
                                                navigateToNextView = true
                                            }
                                        }) {
                                            HStack {
                                                Image(systemName: "arrow.right.circle.fill")
                                                    .font(.system(size: 35))
                                                    .foregroundColor(.black)
                                                    .padding(12)
                                            }
                                        }
                                        .padding()
                                    }
                                }
                            }
                        )
                    
                    Image("DSKids")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
}

struct HowToPlayContent: View {
    var imageName: String
    var text: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
            
            Text(text)
                .padding()
                .multilineTextAlignment(.center)
        }
    }
}

struct YourNextView: View {
    var body: some View {
        Text("Your Next View")
            .font(.title)
    }
}

struct PlayingTips_Previews: PreviewProvider {
    static var previews: some View {
        PlayingTips()
    }
}

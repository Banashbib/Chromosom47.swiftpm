//
//  Catagories.swift
//  Chromosom47
//
//  Created by Bana Alshabib on 02/08/1445 AH.
//neww


import SwiftUI

struct Categories: View {
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color("Beige")
                HStack(spacing: 50) {
                    VStack(spacing: 50){
                        //School
                        NavigationLink(destination: CustomCategoryView(
                            rectangles: [
                                [("📗", "Book", ["Book"]), ("🎪", "Circus", ["Circus"])],
                                [("✏️", "Pencil", ["Pencil"]), ("✂️", "Scissors", ["Scissors"])],
                                [("🎧", "AirPods", ["AirPods"]), ("📏", "Ruler", ["Ruler"])],
                                [("🎱", "Billiard", ["Billiard"]), ("🛣️", "Street", ["Street"])]
                            ],
                            audioPlayerResource: "School",
                            correctAnswers: ["📗", "✏️", "✂️", "📏"],
                            destination: AnyView(Canvas(title: "School", imageName: "SchoolOutline", titleColor: Color("SchoolColor"))),
                            bodyText: "School",
                            bodyTextColor: Color("SchoolColor")
                        )) {
                            ButtonRectangle(imageName: "SchoolOutline", title: "School", titleColor: Color("SchoolColor"))
                        }
                        
                        //Food
                        NavigationLink(destination: CustomCategoryView(
                            rectangles: [
                                [("🐸", "Frog", ["Frog"]), ("🎪", "Circus", ["Circus"])],
                                [("🫑", "Paper", ["Paper"]), ("⚒️", "Hammer", ["Hammer"])],
                                [("🍊", "Orange", ["Orange"]), ("🥪", "Sandwich", ["Sandwich"])],
                                [("🦮", "Dog", ["Dog"]), ("🥗", "Salad", ["Salad"])]
                            ],
                            audioPlayerResource: "Food",
                            correctAnswers: ["🫑", "🍊", "🥪", "🥗"],
                            destination: AnyView(Canvas(title: "Food", imageName: "FoodOutline", titleColor: Color("FoodColor"))),
                            bodyText: "Food",
                            bodyTextColor: Color("FoodColor")
                        )) {
                            ButtonRectangle(imageName: "FoodOutline", title: "Food", titleColor: Color("FoodColor"))
                        }
                    }
                        //Animals
                        VStack(spacing: 50){
                            NavigationLink(destination: CustomCategoryView(
                                rectangles: [
                                    [("🐒", "Monkey", ["Monkey"]), ("🐸", "Frog", ["Frog"])],
                                    [("✏️", "Pencil", ["Pencil"]), ("🔩", "Bolt", ["Bolt"])],
                                    [("🐈", "Cat", ["Cat"]), ("🥪", "Sandwich", ["Sandwich"])],
                                    [("🦮", "Dog", ["Dog"]), ("🪛", "Screwdriver", ["Screwdriver"])]
                                ],
                                audioPlayerResource: "Animals",
                                correctAnswers: ["🐒", "🐸", "🐈", "🦮"],
                                destination: AnyView(Canvas(title: "Animals", imageName: "AnimalsOutline",titleColor: Color("AnimalsColor"))),
                                bodyText: "Animals",
                                bodyTextColor: Color("AnimalsColor")
                            )) {
                                ButtonRectangle(imageName: "AnimalsOutline", title: "Animals", titleColor: Color("AnimalsColor"))
                            }
                            //Tools
                            NavigationLink(destination: CustomCategoryView(
                                rectangles: [
                                    [("📗", "Book", ["Book"]), ("⚒️", "Hammer", ["Hammer"])],
                                    [("🪚", "Saw", ["Saw"]), ("🎧", "AirPods", ["AirPods"])],
                                    [("🔩", "Bolt", ["Bolt"]), ("🪛", "Screwdriver", ["Screwdriver"])],
                                    [("🎱", "Billiard", ["Billiard"]), ("🐒", "Monkey", ["Monkey"])]
                                ],
                                audioPlayerResource: "Tools",
                                correctAnswers: ["⚒️", "🪚", "🔩", "🪛"],
                                destination: AnyView(Canvas(title: "Tools", imageName: "ToolsOutline",titleColor: Color("ToolsColor"))),
                                bodyText: "Tools",
                                bodyTextColor: Color("ToolsColor")
                            )) {
                                ButtonRectangle(imageName: "ToolsOutline", title: "Tools", titleColor: Color("ToolsColor"))
                            }
                            
                        }
                    }
                    
                }.edgesIgnoringSafeArea(.all)
            }
        }
        }
    
        struct ButtonRectangle: View {
            let imageName: String
            let title: String
            let titleColor: Color
            
            var body: some View {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.25), radius: 23, x: 0, y: 4)
                    
                    VStack {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                        
                        Text(title)
                            .font(.title)
                            .bold()
                            .foregroundColor(titleColor)
                    }
                }
                .frame(width: 312, height: 312)
            }
        }
        
        struct Categories_Previews: PreviewProvider {
            static var previews: some View {
                Categories()
            }
        }
    

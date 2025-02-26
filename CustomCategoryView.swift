//
//  School.swift
//  Chromosom47
//
//  Created by Bana Alshabib on 04/08/1445 AH.

import UniformTypeIdentifiers
import SwiftUI
import AVKit

struct CustomCategoryView: View {
    var rectangles: [[(String, String, [String])]]
    var audioPlayer: AVPlayer
    var correctAnswers: Set<String>
    var destination: AnyView
    var bodyText: String
    var bodyTextColor: Color
    
    @State private var selectedRectangles: [Int: (String, String, [String])] = [:]
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToColoring = false
    @State private var navigateToStart = false
    @State private var isPlaying = false
    @State private var audioProgress: Float = 0.0

    init(
        rectangles: [[(String, String, [String])]],
        audioPlayerResource: String,
        correctAnswers: Set<String>,
        destination: AnyView,
        bodyText: String,
        bodyTextColor: Color
    ) {
        self.rectangles = rectangles
        self.audioPlayer = AVPlayer(url: Bundle.main.url(forResource: audioPlayerResource, withExtension: "mp3")!)
        self.correctAnswers = correctAnswers
        self.destination = destination
        self.bodyText = bodyText
        self.bodyTextColor = bodyTextColor
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Beige").edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    HStack {
                        Spacer()
                        Button(action: {
                            if self.isPlaying {
                                self.audioPlayer.pause()
                            } else {
                                self.audioPlayer.play()
                            }
                            self.isPlaying.toggle()
                        }) {
                            Image(systemName: self.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                .font(.system(size: 70))
                                .foregroundColor(Color.black)
                        }
                    }
                    
                    Text(bodyText)
                        .font(.custom("Impact", fixedSize: 70))
                        .bold()
                        .foregroundColor(bodyTextColor)
                    
                    HStack(spacing: 20) {
                        ForEach(rectangles.indices, id: \.self) { row in
                            VStack(spacing: 20) {
                                ForEach(rectangles[row].indices, id: \.self) { column in
                                    RectangleView(content: rectangles[row][column], isSelected: isSelected(row, column))
                                        .onTapGesture {
                                            handleSelection(row, column)
                                        }
                                }
                            }
                        }
                    }
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            checkAnswers()
                        }) {
                            Text("Check")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 4)
                        }
                    }
                }
                .padding()
            }
            
            .alert(isPresented: $showAlert) {
                switch alertMessage {
                case "You answered right now enjoy the coloring 🎨 !":
                    return Alert(
                        title: Text("Good Job 🌟!"),
                        message: Text(alertMessage),
                        primaryButton: .default(
                            Text("Move to Coloring"),
                            action: {
                                navigateToColoring = true
                            }
                        ),
                        secondaryButton: .default(
                            Text("Back to Menu"),
                            action: {
                                navigateToStart = true
                            }
                        )
                    )
                case "You missed some shapes please try again!":
                    return Alert(
                        title: Text("Try Again 🔄!"),
                        message: Text(alertMessage),
                        primaryButton: .default(
                            Text("Try Again"),
                            action: {
                                // Handle "Try Again" logic here
                            }
                        ),
                        secondaryButton: .default(
                            Text("Back to Menu"),
                            action: {
                                navigateToStart = true
                            }
                        )
                    )
                default:
                    return Alert(title: Text("Result"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }

            .background(
                NavigationLink(destination: destination, isActive: $navigateToColoring) {
                    EmptyView()
                }
                .hidden()
            )
            .background(
                NavigationLink(destination: Categories(), isActive: $navigateToStart) {
                    EmptyView()
                }
                .hidden()
            )
        }
    }
    
    func isSelected(_ row: Int, _ column: Int) -> Bool {
        selectedRectangles.values.contains { $0 == rectangles[row][column] }
    }

    func handleSelection(_ row: Int, _ column: Int) {
        if let index = selectedRectangles.firstIndex(where: { $0.value == rectangles[row][column] }) {
            selectedRectangles.remove(at: index)
        } else {
            if selectedRectangles.count < 4 {
                selectedRectangles[selectedRectangles.count] = rectangles[row][column]
            }
        }
    }

    func checkAnswers() {
        let userAnswerEmojis = Set(selectedRectangles.values.map { $0.0 })
        let correctAnswerEmojis = correctAnswers

        if userAnswerEmojis == correctAnswerEmojis {
            showAlert = true
            alertMessage = "You answered right now enjoy the coloring 🎨 !"
        } else {
            showAlert = true
            alertMessage = "You missed some shapes please try again!"
        }
    }
}

struct RectangleView: View {
    let content: (String, String, [String])
    let isSelected: Bool
    @State private var isPlaying = false
    @State private var audioProgress: Float = 0.0
    @State private var audioPlayers: [AVPlayer]

    init(content: (String, String, [String]), isSelected: Bool) {
        self.content = content
        self.isSelected = isSelected
        self._audioPlayers = State(initialValue: content.2.map {
            guard let fileURL = Bundle.main.url(forResource: $0, withExtension: "mp3") else {
                fatalError("Could not find \($0).mp3 in the main bundle.")
            }
            return AVPlayer(url: fileURL)
        })
    }

    var body: some View {
        VStack(spacing: 10) {
            Text(content.0)
                .font(.system(size: 50))
                .frame(width: 150, height: 80)
                .background(Color.white)
                .cornerRadius(10)

            Text(content.1)
                .font(.headline)
                .foregroundColor(.black)
            Button(action: {
                if self.isPlaying {
                    self.audioPlayers.forEach { $0.pause() }
                } else {
                    self.audioPlayers.forEach { $0.play() }
                }
                self.isPlaying.toggle()
            }) {
                Image(systemName: self.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.black)
            }
        }
        .padding()
        .background(isSelected ? Color.blue.opacity(0.2) : Color.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 4)
    }

}

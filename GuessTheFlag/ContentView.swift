//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Brandon Coston on 2/28/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingWon = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var flagRotations = [0.0, 0.0, 0.0]
    @State private var flagOpacity = [1.0, 1.0, 1.0]
    @State private var flagBlur = [0.0, 0.0, 0.0]
    @State private var userScore = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(imageName: countries[number])
                        }
                        .blur(radius: flagBlur[number])
                        .opacity(flagOpacity[number])
                        .rotation3DEffect(Angle(degrees: flagRotations[number]), axis: (x: 0, y: 1, z: 0))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }
        .alert("You Won!", isPresented: $showingWon) {
            Button("Play Again", action: startOver)
        }
    }
    
    func flagTapped(_ number: Int) {
        adjustFlagUI(number)
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            showingWon = userScore >= 8
            if (!showingWon) {
                askQuestion()
            }
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            showingScore = true
        }
    }
    
    func adjustFlagUI(_ number: Int) {
        flagRotations = [0.0, 0.0, 0.0]
        flagOpacity = [1.0, 1.0, 1.0]
        flagBlur = [0.0, 0.0, 0.0]
        withAnimation {
            flagRotations[number] += 360
            for i in 0..<3 {
                if i != number {
                    flagOpacity[i] = 0.25
                    flagBlur[i] = 10.0
                }
            }
        }
    }
    
    func askQuestion() {
        flagRotations = [0.0, 0.0, 0.0]
        flagOpacity = [1.0, 1.0, 1.0]
        flagBlur = [0.0, 0.0, 0.0]
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func startOver() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        userScore = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

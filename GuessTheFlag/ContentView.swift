

import SwiftUI

struct FlagImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                
        
    }
}

extension View {
    func imageStyle() -> some View {
        modifier(FlagImage())
        //comment
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingRestart = false
    @State private var scoreTitle = ""
    @State private var scoreValue = 0
    @State private var animationAmount = 0.0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        
        ZStack {
//            Color.gray
//                .ignoresSafeArea()
            
            LinearGradient(gradient: Gradient(colors: [.indigo, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                
            
            VStack(spacing: 30) {
               Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
                VStack {
                    Text("Tap the flag of")
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                        
                } .foregroundColor(.white)
                
                ForEach(0..<3) {number in
                    Button {
                        //test
                        withAnimation {
                            
                            if number == correctAnswer {
                                animationAmount += 360
                            }
                            
                        }
                        flagTapped(number)
                        
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .imageStyle()
                            
                            
                    }
                    
                    
                }
                .rotation3DEffect(.degrees(animationAmount), axis: (x: 0,y: 1, z: 0))
               
                Spacer()
                Text("Your score is \(scoreValue)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                Spacer()
                
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(scoreValue)")
        }
        .alert("Your score is 8. Awesome!", isPresented: $showingRestart) {
            Button("Start new game", role: .destructive, action: askQuestion)
        } message: {
            Text("Wanna start again?")
                .foregroundColor(.red)
        }
    }
    
    
    func flagTapped(_ number: Int) {
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreValue += 1
            if scoreValue > 7 {
                scoreValue = 0
                showingRestart = true
                return
            }
            
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//
//
//VStack(alignment: .leading, spacing: 20) {
//    Color.blue
//        .frame(width: 200, height: 200, alignment: .center)
//        .frame(minWidth: 200, maxWidth: .infinity, maxHeight: 200)
//    Color.primary
//    Color.secondary
//    Color(red: 1, green: 1, blue: 1)
//    LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
//
//
//    Text("A")
//        .foregroundColor(.secondary)
//        .foregroundStyle(.secondary)
//        .padding(50)
//        .background(.ultraThinMaterial)
//
//} .background(.red)
//    .ignoresSafeArea()
//
//HStack {
//
//    Button("Delete selection") {
//        print("Now deleting…")
//    }
//
//    Button("Button 1") { }
//            .buttonStyle(.bordered)
//
//    Button("Button 2", role: .destructive) { }
//            .buttonStyle(.bordered)
//            .tint(.mint)
//    Button("Button 3") { }
//            .buttonStyle(.borderedProminent)
//
//    Button("Button 4", role: .destructive) { }
//            .buttonStyle(.borderedProminent)
//
//    Button {
//        print("Button was tapped")
//    } label: {
//        Image(systemName: "pencil")
//        Label("Edit", systemImage: "pencil")
//        Text("Tap me!")
//            .padding()
//            .foregroundColor(.white)
//            .background(.red)
//    }
//
//
//    @State private var showingAlert = false
//    Button("Show Alert") {
//        showingAlert = true
//    }
//    .alert("Important message", isPresented: $showingAlert) {
//        Button("OK", role: .destructive) { }
//        Button("cancel", role: .cancel) { }
//    } message: {
//        Text("Please read this.")
//    }
//}
//ZStack {}

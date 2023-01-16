//
//  ContentView.swift
//  SwiftNavigation
//
//  Created by Cody Torgovnik on 12/16/22.
//

import SwiftUI


struct ContentView: View {
    
    
    let backgroundGradient = LinearGradient(
        colors: [Color.red, Color.blue],
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        let weatherService = WeatherService()
        
        let viewModel = WeatherViewModel(weatherService: weatherService)
        
            
        NavigationView{
            
            ZStack{
                backgroundGradient
                    .scaleEffect(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                VStack{
                    WeatherView(viewModel: viewModel)
                        .frame(height: 50)
                    NavigationLink(destination: AffirmationView()){
                        Text("To your daily affirmation")
                            .foregroundColor(.white)
                            .padding(12)
                    }
                    .background(Color.red)
                    .cornerRadius(12)
                    .offset( y: 170)
                    .navigationBarTitle(
                        Text("Good Morning"))
                }
            }
            
            
            
        }
        
        
        
        
    }
}

struct AffirmationView: View {
    
    let lastDisplayedDateKey = "lastDisplayedDate"


    // List of daily affirmations
    let affirmations = [
        "You are loved.",
        "You are beautiful.",
        "You are strong.",
        "You are worthy.",
        "You are enough.",
    ]

    // State variable to store the current daily affirmation
    @State private var affirmation: String = "loading"
    @State private var buttonHidden = false
    @ObservedObject var listViewModel = ListViewModel()
    
    var canNavigate: Bool = true

    // Function to display a random daily affirmation
//    func showAffirmation(){
//        // Choose a random affirmation from the list
//        let index = Int.random(in: 0..<affirmations.count)
//        affirmation = affirmations[index]
//    }
    func showAffirmation() {
        let currentDate = Date()
        let lastDisplayedDate = UserDefaults.standard.object(forKey: lastDisplayedDateKey) as? Date

        // If the dates are different, display a new affirmation
        if lastDisplayedDate == nil || Calendar.current.compare(currentDate, to: lastDisplayedDate!, toGranularity: .day) != .orderedSame {
            // Choose a random affirmation from the list
            let index = Int.random(in: 0..<affirmations.count)
            affirmation = affirmations[index]

            // Update the user default with the current date
            UserDefaults.standard.set(currentDate, forKey: lastDisplayedDateKey)
        }
    }
    // Initialize the affirmation variable with the stored affirmation from the UserDefaults object
    
//    func showAffirmation() {
//        let currentDate = Date()
//            let lastDisplayedDate = UserDefaults.standard.object(forKey: lastDisplayedDateKey) as? Date
//
//            // If the dates are different, display a new affirmation
//            if lastDisplayedDate == nil || Calendar.current.compare(currentDate, to: lastDisplayedDate!, toGranularity: .day) != .orderedSame {
//                // Choose a random affirmation from the list
//                let index = Int.random(in: 0..<affirmations.count)
//                affirmation = affirmations[index]
//
//                // Update the user default with the current date
//                UserDefaults.standard.set(currentDate, forKey: lastDisplayedDateKey)
//        }
//    }
//
    
    var body: some View {
        
        /*let weatherService = WeatherService()
        let viewModel = WeatherViewModel(weatherService: weatherService)*/
    
        ZStack{
            AnimatedBackground()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(affirmation)
                    .font(.title)
                    
                
                /*CircleView(color: .red, aff: showAffirmation())*/
                
                /*if !buttonHidden { Button(action: {
                 showAffirmation()
                 
                 self.buttonHidden = true
                 }) {
                 Text("Show Affirmation")
                 }*/
                
            }
            .onAppear(){showAffirmation()}
            
            if (canNavigate){
                NavigationLink(destination:
                    MotivationView()){
                        Text("Get Your Day Started")
                            .foregroundColor(.white)
                            .padding(12)
                    }
                    .background(Color.red)
                    .cornerRadius(12)
                    .offset( y: 170)
                .navigationBarTitle(
                    Text("Affirmation"))
            }
            
        }
        
        
        
    }
    
}

struct MotivationView: View {

    // List of daily affirmations
    let motivations = [
        "You are loved.",
        "You are beautiful.",
        "You are strong.",
        "You are worthy.",
        "You are enough.",
    ]
    

    // State variable to store the current daily motivational quote
    @State private var motivation = "loading"
    @State private var buttonHidden = false
    @ObservedObject var listViewModel = ListViewModel()
    
    var canNavigate: Bool = true

    // Function to display a random daily motivational quote
    func showMotivation(){
        // Choose a random affirmation from the list
        let index = Int.random(in: 0..<motivations.count)
        motivation = motivations[index]
    }
    
    
    var body: some View {
        
        /*let weatherService = WeatherService()
        let viewModel = WeatherViewModel(weatherService: weatherService)*/
    
        ZStack{
            BouncingCircles()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(motivation)
                    .font(.title)
                    
                
                /*CircleView(color: .red, aff: showAffirmation())*/
                
                /*if !buttonHidden { Button(action: {
                 showAffirmation()
                 
                 self.buttonHidden = true
                 }) {
                 Text("Show Affirmation")
                 }*/
                
            }
            .onAppear(){showMotivation()}
            
                
            if (canNavigate){
                Text("Get your day going and head to your to do list!")
                    .padding(12)
                    .offset(y: 150)
                    .font(.system(size: 15))
                    //.frame(width: 200, height: 50)
                    .font(.headline)
                NavigationLink(destination: ToDoListView()) {
                    Text("->")
                        .foregroundColor(.white)
                        .padding(20)
                        .font(.system(size: 20))
                }
                .background(Color.blue)
                .cornerRadius(12)
                .offset(x: 125, y: 180)
            }
        }
        
        
        
    }
    
}

struct ToDoListView: View{
    @ObservedObject var listViewModel = ListViewModel()
    var body: some View{
        VStack {
            
            ListView(date: Date())
            NavigationLink(destination: MainMenuSystem()){
                Text("Main Menu")
            }
            //.navigationBarBackButtonHidden(true)
            //.navigationBarBackButtonHidden(false)
        }
    }
}


struct AnimatedBackground: View {
    @State private var offset = CGSize.zero

    var body: some View {
        ZStack {
            // Add a gradient background
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [.orange, .yellow]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Add the animated circle
//            Circle()
//                .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
//                .frame(width: 300, height: 300)
//                .offset(offset)
            BouncingCircles()
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                self.offset = CGSize(width: 100, height: 100)
            }
        }
    }
}


struct MotivationAnimatedBackground: View {
    @State private var startColor: Color = .red
    @State private var endColor: Color = .yellow

    var body: some View {
        LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .onAppear {
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: true)) {
                    self.startColor = .yellow
                    self.endColor = .red
                }
            }
    }
}

//struct BouncingCircles: View {
//    @State private var xOffset: CGFloat = 0.0
//    @State private var yOffset: CGFloat = 0.0
//    @State private var angle: Double = 0.0
//
//    var body: some View {
//        VStack {
//            ForEach(0..<5) { index in
//                Circle()
//                    .frame(width: 100, height: 100)
//                    .opacity(1.0 - Double(index) / 5.0)
//                    .offset(x: self.xOffset, y: self.yOffset)
//                    .rotationEffect(.degrees(self.angle))
//                    .foregroundColor(Color.purple)
//            }
//        }
//        .onAppear {
//            withAnimation(Animation.linear(duration: 10).repeatForever(autoreverses: true)) {
//                self.xOffset = self.xOffset == 0 ? -100 : 0
//                self.yOffset = self.yOffset == 0 ? -100 : 0
//                self.angle = self.angle == 0 ? 180 : 0
//            }
//        }
//    }
//}
struct BouncingCircles: View {
    @State private var xOffsets: [CGFloat] = (0..<10).map { _ in CGFloat.random(in: -200...200) }
    @State private var yOffsets: [CGFloat] = (0..<10).map { _ in CGFloat.random(in: -200...200) }
    @State private var angles: [Double] = (0..<10).map { _ in Double.random(in: 0...360) }

    var body: some View {
        VStack {
            ForEach(0..<10) { index in
                Circle()
                    .frame(width: 100, height: 100)
                    .opacity(1.0 - Double(index) / 10.0)
                    .offset(x: self.xOffsets[index], y: self.yOffsets[index])
                    .rotationEffect(.degrees(self.angles[index]))
                    .foregroundColor(Color.purple)
            }
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 10).repeatForever(autoreverses: true)) {
                self.xOffsets = (0..<10).map { _ in CGFloat.random(in: -200...200) }
                self.yOffsets = (0..<10).map { _ in CGFloat.random(in: -200...200) }
                self.angles = (0..<10).map { _ in Double.random(in: 0...360) }
            }
        }
    }
}


struct CircleView: View{
    
    var color: Color
    var aff: String
    
    var body: some View{
        Circle()
            .frame(width: 200, height: 200)
            .foregroundColor(color)
        Text(aff)
            .foregroundColor(.white)
            .font(.system(size: 70, weight: .bold))
    }
}

/*struct ToDoView: View{
    var body: some View{
        VStack{
            Text("hi")
        }
    }
}*/



struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .environmentObject(ListViewModel())
            .environmentObject(DateHolder())
    }
}

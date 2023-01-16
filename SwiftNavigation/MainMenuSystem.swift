//
//  MainMenuSystem.swift
//  SwiftNavigation
//
//  Created by Cody Torgovnik on 12/23/22.
//

import SwiftUI

/*struct MainMenuSystem: View {
    
    let dateHolder = DateHolder()
   
    
    
    var body: some View {
        let weatherService = WeatherService()
        let viewModel = WeatherViewModel(weatherService: weatherService)
        VStack{
            Text("It's going to be a great day!")
                .offset(y: -50)
            CalendarView()
                .environmentObject(dateHolder)
                .offset(y: 0)
                .frame(height: 300)
//            Text("Menu options")
//                .offset(y: 50)
            HStack{
                NavigationLink(destination: ListView()){
                    Text("To Do List")
                }
                
                NavigationLink(destination: WeatherView(viewModel: viewModel, color: .blue, opac: 1)){
                    Text("Weather")
                }
                
             
                //.navigationBarTitle(
                    //Text("Affirmation"))
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}*/

struct MainMenuSystem: View {
    let dateHolder = DateHolder()

    var body: some View {
        let weatherService = WeatherService()
        let viewModel = WeatherViewModel(weatherService: weatherService)
        VStack {
            Text("It's going to be a great day!")
                
                .font(.largeTitle)
                .bold()
                .padding(.top, 40)
                .frame(width: 300, alignment: .center)
                
        
            CalendarView()
                .environmentObject(dateHolder)
                .frame(height: 300)
            HStack {
                NavigationLink(destination: ListView()) {
                    VStack{
                        Image("to-do-list")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(12)
                        Text("To-Do list")
                            .font(.system(size: 14))
                    }
                }
                NavigationLink(destination: WeatherView(viewModel: viewModel, color: .purple .opacity(0.5), opac: 1)) {
                    VStack{
                        Image("weather-icon")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(12)
                        Text("Weather")
                            .font(.system(size: 14))
                    }
                }
                NavigationLink(destination: AffirmationView(canNavigate: false)) {
                    VStack{
                        Image("affirmation")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(12)
                        Text("Affirmation")
                            .font(.system(size: 14))
                    }
                }
                NavigationLink(destination: MotivationView( canNavigate: false)) {
                    VStack{
                        Image("motivation")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(12)
                        Text("Motivation")
                            .font(.system(size: 14))
                    }
                }
            }
            .padding()
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}




struct MainMenuSystem_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuSystem()
    }
}

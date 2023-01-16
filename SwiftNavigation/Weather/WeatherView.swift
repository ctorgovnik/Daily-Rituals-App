//
//  Weather.swift
//  SwiftNavigation
//
//  Created by Cody Torgovnik on 12/20/22.
//

//import Foundation
import SwiftUI

struct WeatherView: View{
    
    @ObservedObject var viewModel: WeatherViewModel
    var color: Color = .white
    var opac: Double = 0.0
    
    var body: some View{
        ZStack{
                color
                .opacity(opac)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text(viewModel.cityName)
                    .font(.largeTitle)
                    .padding()
                Text(viewModel.temperature)
                    .font(.system(size: 70))
                    .bold()
                Text(viewModel.weatherIcon)
                    .font(.largeTitle)
                    .padding()
                Text(viewModel.weatherDescription)
            }.onAppear(perform: viewModel.refresh)
        }
    }
}

struct WeatherView_Previews: PreviewProvider{
    static var previews: some View{
        WeatherView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}


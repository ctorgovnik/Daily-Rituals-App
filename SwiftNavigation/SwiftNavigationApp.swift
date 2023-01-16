//
//  SwiftNavigationApp.swift
//  SwiftNavigation
//
//  Created by Cody Torgovnik on 12/16/22.
//

import SwiftUI

@main
struct SwiftNavigationApp: App {
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    @StateObject var dateHolder: DateHolder = DateHolder()
    
    var body: some Scene {
        WindowGroup {
            /*let weatherService = WeatherService()
            let viewModel = WeatherViewModel(weatherService: weatherService)
            WeatherView(viewModel: viewModel)*/
            ContentView()
                .environmentObject(listViewModel)
                .environmentObject(dateHolder)
            
            
            
        }
    }
}

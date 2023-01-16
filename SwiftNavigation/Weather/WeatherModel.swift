//
//  WeatherModel.swift
//  SwiftNavigation
//
//  Created by Cody Torgovnik on 12/20/22.
//
// this class holds the model data that our view model will use

import Foundation
//import SwiftUI

public struct Weather{
    let city: String
    let temperature: String
    let description: String
    let iconName: String
    
    init(response: APIResponse){
        city = response.name
        temperature = "\(Int(response.main.temp))"
        description = response.weather.first?.description ?? ""
        iconName = response.weather.first?.iconName ?? ""
    }
}

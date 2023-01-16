//
//  WeatherService.swift
//  SwiftNavigation
//
//  Created by Cody Torgovnik on 12/20/22.
//
// Get the User's location and weather from OpenWeather map

// library to obtain user's location
import CoreLocation
import Foundation

public final class WeatherService: NSObject {
    
    private let locationManager = CLLocationManager()
    private let API_KEY = "a40012ea6749d1d9e397b7a1dfb01c06"
    private var completionHandler: ((Weather) -> Void)?
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData(_ completionHandler: @escaping ((Weather) -> Void)){
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // send a request to Openweather Map using theese coordinates and API Key to get weather for this location
    // https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D){
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=imperial"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in guard error == nil, let data = data else { return }
            if let response = try?  JSONDecoder().decode(APIResponse.self, from: data){
                self.completionHandler?(Weather(response: response))
            }
            
        }.resume()
    }
}

extension WeatherService: CLLocationManagerDelegate{
    
    // called when user's location is updated
    public func locationManager( _ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.first else { return }
        makeDataRequest(forCoordinates: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("Something went wrong: \(error.localizedDescription)")
    }
    
}

struct APIResponse: Decodable{
    // name of city
    let name: String
    let main: APIMain
    let weather: [APIWeather]
}

struct APIMain: Decodable{
    // get temperature
    let temp: Double
}

struct APIWeather: Decodable{
    let description: String
    let iconName: String
    
    enum CodingKeys: String, CodingKey{
        case description
        case iconName = "main"
    }
}


//
//  Affirmation.swift
//  SwiftNavigation
//
//  Created by Cody Torgovnik on 12/30/22.
//

import Foundation

struct Affirmation: Codable {
    let text: String
    
    func fetchAffirmations(completion: @escaping ([Affirmation]) -> Void) {
        // Set up the URL request
        let url = URL(string: "https://api.myaffirmations.com/affirmations")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Set up the URLSession
        let session = URLSession.shared
        
        // Make the request
        let task = session.dataTask(with: request) { data, response, error in
            // Check for errors
            if let error = error {
                print(error)
                return
            }
            
            // Parse the response data
            do {
                let affirmations = try JSONDecoder().decode([Affirmation].self, from: data!)
                completion(affirmations)
            } catch {
                print(error)
            }
        }
        
        // Start the task
        task.resume()
    }
}



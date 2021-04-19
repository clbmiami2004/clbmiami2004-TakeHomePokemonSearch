//
//  APIController.swift
//  TakeHomePokemonSearch
//
//  Created by Christian Lorenzo on 4/17/21.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case push = "PUSH"
}

enum NetworkError: Error {
    case otherError
    case badData
    case noDecode
    case noData
}

class APIController {
    
    //MARK: - Propeties:
    var pokemonArray: [MyPokemon] = []
    var pokemonImages: [URL] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    
    //MARK: - Data Fetching from API:
    func fetchPokemon(pokemonName: String, completion: @escaping (Result<MyPokemon, Error>) -> Void) {
        let pokemonUrl = baseURL?.appendingPathComponent(pokemonName.lowercased())
        guard let pokeUrl = pokemonUrl else { return }
        var request = URLRequest(url: pokeUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (possibleData, _, possibleError) in
            if let possibleError = possibleError {
                print("Error fetching data \(possibleError)")
                return
            }
            
            guard let possibleData = possibleData else {
                print("No data returned from Data Task")
                return
            }
            
            do {
                let pokemonResult = try JSONDecoder().decode(MyPokemon.self, from: possibleData)
                completion(.success(pokemonResult))
            } catch (let error){
                completion(.failure(error))
            }
        }.resume()
    }
    
    //MARK: - Fetching Sprites/Images:
    func fetchImage(from imageURL: String, completion: @escaping(UIImage?) -> Void) {
        guard let imageURL = URL(string: imageURL) else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (possibleImage, _, possibleError) in
            if let possibleError = possibleError {
                NSLog("There was an error fetching the image: \(possibleError)")
                return
            }
            
            guard let data = possibleImage else {
                NSLog("No data provided for image from Url: \(imageURL)")
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
            
        }.resume()
    }
}

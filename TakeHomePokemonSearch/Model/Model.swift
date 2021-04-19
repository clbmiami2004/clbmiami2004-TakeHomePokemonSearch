//
//  Model.swift
//  TakeHomePokemonSearch
//
//  Created by Christian Lorenzo on 4/17/21.
//

import Foundation
import UIKit


struct MyPokemon: Codable, Equatable {
    
    let name: String
    let types: [TypeInfo]
    let id: Int
    let abilities: [AbilityInfo]
    let sprites: SpriteFront
    let base_experience: Int
    
    struct AbilityInfo: Codable, Equatable {
        let ability: Ability
        
        struct Ability: Codable, Equatable {
            let name: String
        }
    }
    
    struct TypeInfo: Codable, Equatable {
        let type: TypieType
        
        struct TypieType: Codable, Equatable {
            let name: String
        }
    }
    
    struct SpriteFront: Codable, Equatable {
        let imageUrl: String
        
        enum CodingKeys: String, CodingKey {
            case imageUrl = "front_default"
        }
    }
}

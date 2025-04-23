//
//  PoketApi.swift
//  poketmonApp
//
//  Created by 최영락 on 4/22/25.
//

import Foundation


struct Sprites: Codable {
    let front_default: String
}
struct PoketApi: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    
    //    var sprites = {
    //        let front_default: String
}
/*
 {
 "id": 25,
 "name": "pikachu",
 "height": 4,
 "weight": 60,
 "sprites": {
 "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"
 }
 }
 */

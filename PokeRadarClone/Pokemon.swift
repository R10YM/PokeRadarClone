//
//  File.swift
//  PokeRadarClone
//
//  Created by Meng Yuan on 12/23/16.
//  Copyright © 2016 Meng Yuan. All rights reserved.
//

import Foundation

class Pokemon {
    var pokeName : String!
    var pokeID : Int!
    
    init(index : Int) {
        pokeName = pokemon[index]
        pokeID = index
    }
}

//
//  PokeCell.swift
//  PokeRadarClone
//
//  Created by Meng Yuan on 12/22/16.
//  Copyright © 2016 Meng Yuan. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeImg: UIImageView!
    @IBOutlet weak var pokeName: UILabel!
    
    var poke: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 10.0
    }
    
    func configureCell(poke : Pokemon) {
        self.poke = poke
        pokeName.text = self.poke.pokeName.capitalized
        pokeImg.image = UIImage(named: "\(self.poke.pokeID!+1)")
        print(self.poke.pokeID)
    }
    
    
}

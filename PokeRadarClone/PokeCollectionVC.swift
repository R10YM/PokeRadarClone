//
//  PokeCollectionVC.swift
//  PokeRadarClone
//
//  Created by Meng Yuan on 12/22/16.
//  Copyright © 2016 Meng Yuan. All rights reserved.
//

import UIKit

class PokeCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var userLocation : CLLocation!
    
    var inSearchMode = Bool()
    
    var filtered = [Pokemon]()
    
    var pokemons = [Pokemon]()

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        inSearchMode = false
        searchBar.returnKeyType = UIReturnKeyType.done
        createPokes()
        //print(userLocation)
    }
    
    func createPokes() {
        for i in 0..<pokemon.count {
            let poke = Pokemon(index: i)
            pokemons.append(poke)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            let poke: Pokemon!
            if inSearchMode {
                poke = filtered[indexPath.row]
                cell.configureCell(poke: poke)
            } else {
                poke = pokemons[indexPath.row]
                cell.configureCell(poke: poke)
            }
//            cell.pokeImg.image = UIImage(named: "\(indexPath.item)")
//            cell.pokeName.text = pokemon[indexPath.item]
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    //create a poke sight on user location and return to map
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        createSighting(forLocation: userLocation, withPokemon: indexPath.item)
        self.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filtered.count
        } else {
            return pokemons.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func createSighting(forLocation location: CLLocation, withPokemon pokeId: Int) {
        geoFire?.setLocation(location, forKey: "\(pokeId)")
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //search functions
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            self.view.endEditing(true)
            collectionView.reloadData()
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filtered = pokemons.filter({$0.pokeName.range(of: lower) != nil})
            collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
}

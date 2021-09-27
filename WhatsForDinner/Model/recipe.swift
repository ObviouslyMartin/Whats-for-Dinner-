//
//  recipe.swift
//  WhatsForDinner
//
//  Created by Martin Plut on 4/22/20.
//  Copyright © 2020 Martin Plut. All rights reserved.
//

import Foundation
class Recipe{
    var ingredients = [String]()
    var directions = [String]()
    var name = "Tonight's Dinner"
    var servingSize = 0
    var description = ""
    // recipe Image
    var link = ""
    
    func getIngredients() -> [String]{
        return self.ingredients
    }
    func addIngredient(i: String){
        self.ingredients.append(i)
    }
    func getDirections() -> [String]{
        return self.directions
    }
    func addDirection(i: String){
        self.directions.append(i)
    }
    func reveal(){
        print(self.name)
        print(self.description)
        print(self.link)
        print("--------------------")
//        print(self.servingSize)
//        for i in ingredients.indices{
//            print(ingredients[i])
//        }
//        for i in directions.indices{
//            print("Step: \(i+1)")
//            print(directions[i])
//            print()
//            
//        }
            
    }
    init(name: String, link: String, description: String ){
        self.name = name
        self.description = description
        self.link = link
    }
    
}

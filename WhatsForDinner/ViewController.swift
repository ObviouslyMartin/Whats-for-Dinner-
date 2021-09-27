//
//  ViewController.swift
//  WhatsForDinner
//
//  Created by Martin Plut on 4/22/20.
//  Copyright © 2020 Martin Plut. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setTextViewisHidden(hidden: true)
    }
    @IBOutlet weak var wfdButton: UIButton!
    
    @IBAction func RandomDinner(_ sender: UIButton) {
        displayRandomRecipe()
    }
    
    @IBOutlet weak var linkTextView: UITextView!
    @IBOutlet weak var recipeNameTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    func setTextViewisHidden(hidden: Bool){
        linkTextView.isHidden = hidden
        linkTextView.isEditable = false
        recipeNameTextView.isHidden = hidden
        recipeNameTextView.isEditable = false
        descriptionTextView.isHidden = hidden
        descriptionTextView.isEditable = false
    }
    func listofRecipes() -> [Recipe]{
        let allrecipesURL = "https://www.allrecipes.com/recipes/17562/dinner/"
        let rs = RecipeScrapper(allrecipesURL)
        rs.createRecipeElementArray()
        //let myList = rs.createRecipeObjectArray()
        let myList = rs.createRecipeObjectArray()
        rs.createRecipes()
        return myList
        
//        for i in myList.indices{
//            myList[i].reveal()
//        }
    
        
    }
    func displayRandomRecipe(){
        let myList = listofRecipes()
        let rand = Int.random(in: 0 ..< myList.count)
        print(rand, myList.count)
        recipeNameTextView.text = myList[rand].name
        linkTextView.text = myList[rand].link
        linkTextView.isEditable = false
        linkTextView.dataDetectorTypes = UIDataDetectorTypes.all
        descriptionTextView.text = myList[rand].description
        setTextViewisHidden(hidden: false)
        print("done")
    }
}


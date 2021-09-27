//
//  recipeScrapper.swift
//  WhatsForDinner
//
//  Created by Martin Plut on 4/22/20.
//  Copyright © 2020 Martin Plut. All rights reserved.
//

import Foundation
import SwiftSoup

enum _myerrors: Error{
    case badURLString
}

class RecipeScrapper{
    var allrecipesURL = URL(string: "")
    var allrecipesHTML = ""
    var allrecipesDOC = Document.init("")
    var recipeHTMLList = [Element]()
    var recipeNamesList = [String]()
    var recipeLinks = [String]()
    var myRecipes = [Recipe]()
    
    init(_ url: String){
        self.allrecipesURL = URL(string:url)
        self.allrecipesHTML = try! String(contentsOf: allrecipesURL!, encoding: String.Encoding.ascii)
        self.allrecipesDOC = try! SwiftSoup.parse( self.allrecipesHTML)
        self.recipeHTMLList = []
        self.recipeLinks = []
    }

    func createRecipeElementArray(){
        //using html from main dinner recipe page, parse out all recipe cards into HTMLList and recipeLinks
        
        do{
            self.recipeHTMLList = try self.allrecipesDOC.getElementsByClass("fixed-recipe-card").array()// get all recipes on page
           
            for i in self.recipeHTMLList.indices{
                let linkdivs = try recipeHTMLList[i].getElementsByClass("grid-card-image-container") // get all recipe containers on page
                let links = try linkdivs.select("a[href]").first()! //link and other information in HTML
                let link = try links.attr("href") //individual link
                recipeLinks.append(link) // save link, index corresponds with recipeList indices
            }
            //self.createRecipes()
        }
        catch Exception.Error(let type, let message){
            print(type, message)
        }
        catch{
            print("error")
        }
    }
    
    func getRecipeHTMLList() -> [Element] { return self.recipeHTMLList }
    func getRecipeLinks() -> [String] { return self.recipeLinks}
    func getRecipesNamesList() -> [String] { return self.recipeNamesList }
    func findRecipeLink(at index: Int ) ->  String { return self.recipeLinks[index] }
    
    
    func findRecipeName(at index: Int) -> String {
       // parse main recipe page for recipe name.
        do{
            let data = try self.recipeHTMLList[index].select("ar-save-item").first()!.dataset()
            return data["name"]!
            
        } catch Exception.Error(let type, let message){
            print(type, message)
        }
        catch{
            print("error")
        }
        return ""
    }
    
    func parseRecipeServingSize(from doc: Document) -> Int { return 0 }
    func parseRecipeDirections(from doc: Document) -> [String] { return [""] }
    func parseRecipeIngredients(from doc: Document) -> [String] { return [""] }
    func parseJSONRecipe(from doc: Document) -> [Dictionary <String, Any>] {
        do{
            let obj: String = try doc.getElementsByTag("script").first()!.data()
            return checkJSON(obj: obj)!
        } catch Exception.Error(let type, let message){
            print(type, message)
        }
        catch{
            print("error")
        }
        return [Dictionary <String, Any>]()
    }
    func checkJSON(obj: String) -> [Dictionary <String, Any>]? {
        let data = obj.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
            {
                return jsonArray // use the json here
            } else {
                print("bad json")
                return nil
            }
        } catch let error as NSError {
            print(error)
            return nil
        }
         return nil
    }
    func parseRecipeDescription(at index: Int) -> String {
        //parse description in main recipes page,
        do {
            let data = try self.recipeHTMLList[index].getElementsByClass("fixed-recipe-card__description").first()!.text()
            return data
        } catch Exception.Error(let type, let message){
            print(type, message)
        }
        catch{
            print("error")
        }
        return "_default_description_"
    }
    func createRecipeObjectArray() -> [Recipe] {
        //parse website using recipeHTMLList to extract recipe, name, link, and description
        for i in 0...self.recipeHTMLList.count-1{
            let _name = findRecipeName(at: i)
            let _description = parseRecipeDescription(at: i)
            let _url = findRecipeLink(at: i)
            myRecipes.append(Recipe(name: _name, link:_url, description: _description))
        }
        return self.myRecipes
    }
    func createRecipes(){
        // create a complete list of recipes including, image, servingSize, ingredients, and directions
        
        for i in 0...0{//self.myRecipes.count-1{
//            let recipeURL = URL(string: self.findRecipeLink(at: i))
            let recipeURL = URL(string: "https://www.allrecipes.com/recipe/223050/chef-johns-turkey-sloppy-joes/?internalSource=staff%20pick&referringId=17562&referringContentType=Recipe%20Hub&clickId=cardslot%206")
            let recipeHTML = try! String(contentsOf: recipeURL!, encoding: String.Encoding.ascii)
            let recipeDOC = try! SwiftSoup.parse(recipeHTML)
            print(recipeDOC)
            print(parseJSONRecipe(from: recipeDOC))
            
//            myRecipes[i].servingSize = parseRecipeServingSize(from: recipeDOC)
//            myRecipes[i].ingredients = parseRecipeIngredients(from: recipeDOC)
//            myRecipes[i].directions = parseRecipeDirections(from: recipeDOC)
        }
        
        
       
        
    }
    
}

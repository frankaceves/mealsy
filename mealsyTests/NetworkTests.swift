//
//  NetworkTests.swift
//  mealsyTests
//
//  Created by Frank Aceves on 4/13/22.
//

import XCTest
@testable import mealsy
class NetworkTests: XCTestCase {
    var recipeVM: RecipeViewModel!
    var recipeID: String!
    var sampleRecipeJSON: [String: [String:String?]]!
    let rcTests = RecipeConstructionTests()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        recipeVM = RecipeViewModel()
        recipeID = "53049"
        sampleRecipeJSON = nil
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        recipeVM = nil
        recipeID = nil
    }

    func testDownloadRecipeDetailsProducesNonNilDictionaryValues() throws {
        let expectation = XCTestExpectation(description: "download recipe")
        recipeVM.downloadRecipeDetails(id: recipeID) { resultDict in
            switch resultDict {
            case .failure(let error):
                print(error)
                XCTFail()
            case.success(let recipe):
                XCTAssertNotNil(recipe.allMealItems)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func constructRecipe(from dict: [[String:String?]]) -> RealRecipe? {
        print(#function)
        guard var recipeDict = dict.first else {
            return nil
        }
        //process name, instructions in dictionary
        guard let recipeName = recipeDict[RecipeConstants.recipeName.rawValue] as? String, let recipeInstructions = recipeDict[RecipeConstants.recipeInstructions.rawValue] as? String else {
            return nil
        }
        var recipeToReturn = RealRecipe(mealName: recipeName, mealInstructions: recipeInstructions, ingredients: [])
        //remove name, instructions
        recipeDict.removeValue(forKey: RecipeConstants.recipeName.rawValue)
        recipeDict.removeValue(forKey: RecipeConstants.recipeInstructions.rawValue)
        //construct recipe using remaining items
        var ingredients = rcTests.createIngredientArray(from: recipeDict)
        //print(ingredients)
        recipeToReturn.ingredients = ingredients
        //print(recipeToReturn)
        return recipeToReturn
    }
    func testDownloadRecipeReturnsRecipeWithNoNilItems() throws {
        let expectation = XCTestExpectation(description: "recipe is downloaded and transformed")
        recipeVM.downloadRecipeDetails(id: recipeID) { [unowned self] result in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .success(let dict):
                let modifiedDict = dict.allMealItems
                guard let recipe = self.constructRecipe(from: modifiedDict) else {
                    return
                }
                print(recipe)
                XCTAssertNotNil(recipe.mealName, recipe.mealInstructions)
                XCTAssertTrue(!recipe.ingredients.isEmpty, "ingredients array not empty \(recipe.ingredients)")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
}

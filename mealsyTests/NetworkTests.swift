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
    
    
    func testDownloadRecipeReturnsRecipeWithNoNilItems() throws {
        let expectation = XCTestExpectation(description: "recipe is downloaded and transformed")
        recipeVM.downloadRecipeDetails(id: recipeID) { [unowned self] result in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .success(let dict):
                let modifiedDict = dict.allMealItems
                guard let recipe = recipeVM.constructRecipe(from: modifiedDict) else {
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

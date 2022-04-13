//
//  mealsyTests.swift
//  mealsyTests
//
//  Created by Frank Aceves on 1/24/22.
//

import XCTest
@testable import mealsy

class RecipeConstructionTests: XCTestCase {
    var sampleIngredientsDictionary: [String: String?] = [:]
    var sampleMealDictionary: [String: String?] = [:]
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sampleIngredientsDictionary = [
            "strIngredient1": "Milk",
            "strIngredient2": "Oil",
            "strIngredient3": "Eggs",
            "strIngredient4": "Flour",
            "strIngredient5": "Baking Powder",
            "strIngredient6": "Salt",
            "strIngredient7": "Unsalted Butter",
            "strIngredient8": "Sugar",
            "strIngredient9": "Peanut Butter",
            "strIngredient10": "",
            "strIngredient11": "",
            "strIngredient12": "",
            "strIngredient13": "",
            "strIngredient14": "",
            "strIngredient15": "",
            "strIngredient16": "",
            "strIngredient17": "",
            "strIngredient18": "",
            "strIngredient19": "",
            "strIngredient20": "",
            "strMeasure1": "200ml",
            "strMeasure2": "60ml",
            "strMeasure3": "2",
            "strMeasure4": "1600g",
            "strMeasure5": "3 tsp",
            "strMeasure6": "1/2 tsp",
            "strMeasure7": "25g",
            "strMeasure8": "45g",
            "strMeasure9": "3 tbs",
            "strMeasure10": " ",
            "strMeasure11": " ",
            "strMeasure12": " ",
            "strMeasure13": " ",
            "strMeasure14": " ",
            "strMeasure15": " ",
            "strMeasure16": " ",
            "strMeasure17": " ",
            "strMeasure18": " ",
            "strMeasure19": " ",
            "strMeasure20": " "
        ]
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sampleIngredientsDictionary = [:]
    }
    
    func testSampleIngredientsNotEmpty() throws {
        XCTAssertTrue(!sampleIngredientsDictionary.isEmpty)
    }
    func testSpacingIsNotTreatedAsEmpty() throws {
        let sampleString = " "
        XCTAssertTrue(!sampleString.isEmpty)
    }
    func testSingleSpaceTreatedAsEmpty() throws {
        let sampleString = ""
        XCTAssertTrue(sampleString.isEmpty)
    }
    func testConstructedIngredientHasTwoParts() throws {
        let constructedIngredient = ["Milk" : ""]
        for (ingredient, amount) in constructedIngredient {
            XCTAssertNotNil(ingredient)
            XCTAssertTrue(amount.isEmpty)
        }
    }
    
    func testConstructIngredientArrayNotEmpty() throws {
        let mockIngredientDict = [
            "Milk":"2 ounces",
            "Sugar":"2 tbs"
        ]
        
        let array = constructIngredientsArray(ingredientDict: mockIngredientDict)
        XCTAssertTrue(!array.isEmpty)
    }
    func testFullArrayNotEmpty() throws {
        let array = createIngredientArray(from: sampleIngredientsDictionary)
        XCTAssertTrue(!array.isEmpty)
    }
}

extension RecipeConstructionTests {
    func createIngredientArray(from dict: [String: String?]) -> [RealIngredient] {
        //filter out ingredients and measurements
        //var ingredientNameDict: [Int: String] = [:]
        //var measurementDict: [Int: String] = [:]
        
        var filteredItems: [String: String] = [:]
        
        //filter out nil values
        let itemsWithNilFilteredOut = dict.filter { dict in
            dict.value != nil
        }
        //filter out empty values and spaces
        let itemsWithSpacesFilteredOut = itemsWithNilFilteredOut.filter { dict in
            !dict.value!.isEmpty && dict.value != " "
        }
        //remove all other items other than ingredient & measurement
        let filteredIngredientAndMeasurement = itemsWithSpacesFilteredOut.filter { item in
            item.key != "strIngredient" && item.key != "strMeasure"
        }
        var index = 1
        while index <= filteredIngredientAndMeasurement.count {
            if let name = filteredIngredientAndMeasurement["strIngredient\(index)"] as? String, let measure = filteredIngredientAndMeasurement["strMeasure\(index)"] as? String {
                filteredItems[name] = measure
            }
            index += 1
        }
        print("filtered items count: \(filteredItems.count)\n\(filteredItems)")
        
        //call constructor func
        let array = constructIngredientsArray(ingredientDict: filteredItems)
        return array
    }
    func constructIngredientsArray(ingredientDict: [String: String]) -> [RealIngredient] {
        //take dicts and combine
        var constructedIngredientArray: [RealIngredient] = []
        ingredientDict.forEach { element in
            let name = element.key
            let measure = element.value
            let ingredient = RealIngredient(name: name, measurement: measure)
            constructedIngredientArray.append(ingredient)
        }
        return constructedIngredientArray
    }
}
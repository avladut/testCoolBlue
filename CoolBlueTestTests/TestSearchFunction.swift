//
//  TestSearchFunction.swift
//  CoolBlueTestTests
//
//  Created by Alexandru Vladut on 18/07/2018.
//  Copyright © 2018 Alexandru Vladut. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import CoolBlueTest

class TestSearchFunction: XCTestCase {
    var productListVM:ProductListViewModel?
    var testHttpClient:HTTPRequestAPI?
    
    //TODO: test classes improvised, need refactoring
    private final class TestHttpClient:HTTPRequestAPI {
        
        func searchFor(_ searchString: String, page: Int, completion: @escaping (Dictionary<String, Any>?, Error?) -> Void) {
            if let responseString = PlistManager.sharedInstance.getKeyFromPlist(plistName: TestConstants.testPlistFilename, key: TestConstants.key_test_search_json, bundle:Bundle(for: type(of: self))) as? String {
                if let dataFromString = responseString.data(using: .utf8, allowLossyConversion: false) {
                    do{
                        let json = try JSON(data: dataFromString)
                        if let dict = json.dictionaryObject {
                            
                            completion(dict, nil)
  
                        }
                    }
                    catch {
                        print("Something went wrong")
                    }
                    
                }
            }
        }
        
        func requestProductDetailsWithID(_ productID: String, completion: @escaping (Dictionary<String, Any>?, Error?) -> Void) {
            
        }
        
        
    }
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testHttpClient = TestHttpClient()
        self.productListVM = ProductListViewModel(httpManager: testHttpClient!)
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
       
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testNumberOfElements() {
        self.productListVM?.searchFor(searchString: "Something")
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let numberOfItems = self.productListVM?.getNumberOfRowsForSectionIndex(0)
        XCTAssertEqual(numberOfItems, 24, "There should be 24 items")
        
    }

    
}

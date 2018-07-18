//
//  CoolBlueTestTests.swift
//  CoolBlueTestTests
//
//  Created by Alexandru Vladut on 15/07/2018.
//  Copyright © 2018 Alexandru Vladut. All rights reserved.
//

import XCTest
@testable import CoolBlueTest

class CoolBlueTestTests: XCTestCase {
    var productListVM:ProductListViewModel?
    var testHttpClient:HTTPRequestAPI?
    private final class TestHttpClient:HTTPRequestAPI {
        
        func searchFor(_ searchString: String, page: Int, completion: @escaping (Dictionary<String, Any>?, Error?) -> Void) {
            if let responseString = PlistManager.sharedInstance.getKeyFromPlist(plistName: TestConstants.testPlistFilename, key: TestConstants.key_test_search_json, bundle: Bundle(for: type(of: self))) as? String {
                if let data = responseString.data(using: String.Encoding.utf8) {
                    do {
                        let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                        print(jsonDictionary)
                        completion(jsonDictionary, nil)
                    } catch {
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
        testHttpClient = TestHttpClient()
        self.productListVM = ProductListViewModel(httpManager: testHttpClient!)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

//
//  APITests.swift
//  ShouldiGoTests
//
//  Created by Mohammed on 26/12/2020.
//

import XCTest
@testable import ShouldiGo

class ShouldiGoAPITest: XCTestCase{
    var yelpFetcher = YelpFetcher()
    var customError = CustomError(title: nil, description: "NA", code: 404)
    
    override func setUp(){
        super.setUp()
        // Do stuff
    }
    
    override func tearDown() {
        // Do stuff
        super.tearDown()
    }
    
    func testLocationOfBusiness(){
        let completionExpectation = expectation(description: "Execute completion closure.")
        
        let yelpUrl = getBusinessByLocation(location: "NYC", category: "Bakeries")
        let _ : () = yelpFetcher.fetchYelpResults(url: yelpUrl) { (result, error) in
            if let result = result{
                XCTAssertEqual("\(result.businesses![1].location!.city)", "New York")

                completionExpectation.fulfill()
            }
        }
        wait(for: [completionExpectation], timeout: 6)
    }
    
}

//
//  StoreTests.swift
//  ShouldiGoTests
//
//  Created by Mohammed on 26/12/2020.
//

import XCTest
@testable import ShouldiGo

class ShouldiGoStoreTest: XCTestCase{
    let dataStore = DataStore()
    
    // Test if loadingBasedOnURL() method do load a URL of an image from the disk
    func testfetchBusinessURLFromDisk(){
        let fetchBusinessURL = dataStore.loadingBasedOnURL(forKey: "YZK2hMkmjjIWgHDO2Ksz-Q")
        XCTAssertNotNil(fetchBusinessURL)
    }
    
    
}

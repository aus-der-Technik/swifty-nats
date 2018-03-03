//
//  StringExtensionTests.swift
//  SwiftyNatsTests
//
//  Created by Ray Krow on 2/27/18.
//

import XCTest
@testable import SwiftyNats

class StringExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRemovePrefix() {
        
        let testGroups = [
            "PUB": [ "PUB swift.test 5 \r\n hello": " swift.test 5 \r\n hello" ],
            "INFO": [ "INFO {json}": " {json}" ],
            "SUB": [ "SUB swift.test 1": " swift.test 1" ]
        ]
        
        for (prefix, testCases) in testGroups {
            for (input, expected) in testCases {
                let result = input.removePrefix(prefix)
                XCTAssertTrue(result == expected, "String removed prefix correctly")
            }
        }
        
    }
    
    func testToJsonDicitonary() {
        
        let errMsg = "String was not converted to dict correctly"
        
        let dictString = "{\"sslRequired\": true, \"serverName\": \"nats\", \"rate\": 22, \"tag\": null}"
        guard let dict = dictString.toJsonDicitonary() else { XCTAssertTrue(false, errMsg); return }
        
        let serverName = dict["serverName"] as? String
        let rate = dict["rate"] as? Int
        let sslRequired = dict["sslRequired"] as? Bool
        let tag = dict["tag"] as? String?
        
        XCTAssertTrue(serverName == "nats", errMsg)
        XCTAssertTrue(rate == 22, errMsg)
        XCTAssertTrue(sslRequired == true, errMsg)
        XCTAssertTrue(tag == nil, errMsg)
        
    }
    
    func testRemoveNewlines() {
        
        let testCases = [
            "first line\n next line\n last line\n": "first line next line last line",
            "INFO\n{json from the server}": "INFO{json from the server}"
        ]
        
        for (input, expected) in testCases {
            let result = input.removeNewlines()
            XCTAssertTrue(result == expected, "String did not remove newlines correctly")
        }
    }
    
}

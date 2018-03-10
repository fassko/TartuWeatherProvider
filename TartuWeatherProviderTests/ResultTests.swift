//
//  ResultTests.swift
//  TartuWeatherProvider-iOSTests
//
//  Created by Kristaps Grinbergs on 10/03/2018.
//  Copyright © 2018 Kristaps Grinbergs. All rights reserved.
//

import XCTest

@testable import TartuWeatherProvider

class ResultTests: XCTestCase {
  func testResultSucess() {
    let result = TartuWeatherResult<Int, TartuWeatherError>.success(1)
    
    XCTAssertFalse(result.isFailure)
    XCTAssertTrue(result.isSuccess)
    XCTAssertEqual(result.value, 1)
    XCTAssertNil(result.error)
  }
  
  func testResultFailure() {
    
    let result = TartuWeatherResult<Int, TartuWeatherError>.failure(.queryData)
    
    XCTAssertTrue(result.isFailure)
    XCTAssertFalse(result.isSuccess)
    XCTAssertNil(result.value)
    XCTAssertNotNil(result.error)
  }
}

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
    
    switch result {
    case let .success(value):
      XCTAssertEqual(value, 1)
    case .failure:
      XCTFail("Result should be success")
    }
  }
  
  func testResultFailure() {
    
    let result = TartuWeatherResult<Int, TartuWeatherError>.failure(.queryData)
    
    XCTAssertTrue(result.isFailure)
    XCTAssertFalse(result.isSuccess)
    XCTAssertNil(result.value)
    XCTAssertNotNil(result.error)
    
    switch result {
    case .success:
      XCTFail("Result should be failure")
    case let .failure(error):
      switch error {
      case .queryData:
        print("Error set correctly")
      default:
        XCTFail("Error not correctly set")
      }
    }
  }
}

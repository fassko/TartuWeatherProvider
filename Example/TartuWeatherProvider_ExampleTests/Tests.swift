// https://github.com/Quick/Quick

import XCTest
import TartuWeatherProvider

class TartuWeatherProviderTests: XCTestCase {

  func testWeatherData() {
    let expectation = self.expectation(description: "weatherData")
    
    var data: WeatherData?
    
    TartuWeatherProvider.getWeatherData { result in
      switch result {
      case let .success(value):
        data = value
        expectation.fulfill()
      case let .failure(error):
        print(error)
        XCTFail("Failed to get observations")
      }
    }
    
    waitForExpectations(timeout: 5, handler: nil)
    
    XCTAssertNotNil(data, "Weather data should contain something")
    XCTAssertNotNil(data?.temperature)
    XCTAssertNotNil(data?.humidity)
    XCTAssertNotNil(data?.airPressure)
    XCTAssertNotNil(data?.wind)
    XCTAssertNotNil(data?.windDirection)
    XCTAssertNotNil(data?.precipitation)
    XCTAssertNotNil(data?.irradiationFlux)
    XCTAssertNotNil(data?.measuredTime)
    XCTAssertNotNil(data?.liveImage.small)
    XCTAssertNotNil(data?.liveImage.large)
    XCTAssertNotNil(data?.measuredDate)
  }
  
  func testQueryDataToday() {
    getQueryData(.today)
  }
  
  func testQueryDataYesterday() {
    getQueryData(.yesterday)
  }
  
  func getQueryData(_ type: QueryDataType) {
    let expectation = self.expectation(description: "queryData\(type.description)")
    
    var queryData: [QueryData]?
    
    TartuWeatherProvider.getArchiveData(type) { result in
      switch result {
      case let .success(value):
        queryData = value
        expectation.fulfill()
      case let .failure(error):
        print(error)
        XCTFail("Failed to get observations")
      }
    }
    
    waitForExpectations(timeout: 5, handler: nil)
    
    XCTAssertNotNil(queryData)
    
    guard let firstItem = queryData?[0] else {
      XCTFail()
      return
    }

    XCTAssertNotNil(firstItem.measuredTime)
    XCTAssertNotNil(firstItem.temperature)
    XCTAssertNotNil(firstItem.humidity)
    XCTAssertNotNil(firstItem.airPressure)
    XCTAssertNotNil(firstItem.wind)
    XCTAssertNotNil(firstItem.windDirection)
    XCTAssertNotNil(firstItem.precipitation)
    XCTAssertNotNil(firstItem.uvIndex)
    XCTAssertNotNil(firstItem.light)
    XCTAssertNotNil(firstItem.irradiationFlux)
    XCTAssertNotNil(firstItem.gammaRadiation)
    XCTAssertNotNil(firstItem.measuredDate)
    
    guard let measuredDate = firstItem.measuredDate else {
      XCTFail()
      return
    }
    
    let calendar = Calendar.current
    XCTAssertEqual(calendar.component(.hour, from: measuredDate), 00)
    XCTAssertEqual(calendar.component(.minute, from: measuredDate), 00)
    
    guard let secondItemDate = queryData?[1].measuredDate else {
      XCTFail()
      return
    }
    
    XCTAssertEqual(calendar.component(.hour, from: secondItemDate), 00)
    XCTAssertEqual(calendar.component(.minute, from: secondItemDate), 05)
  }
}

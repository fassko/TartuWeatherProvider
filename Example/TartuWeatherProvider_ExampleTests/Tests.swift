// https://github.com/Quick/Quick

import XCTest
import TartuWeatherProvider

class TartuWeatherProviderTests: XCTestCase {
  func testExample() {
    let expectation = self.expectation(description: "weatherData")
    
    var data: WeatherData?
    
    TartuWeatherProvider.getWeatherData {result in
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
    XCTAssertNotNil(data?.precipitation)
    XCTAssertNotNil(data?.irradiationFlux)
    XCTAssertNotNil(data?.measuredTime)
    XCTAssertNotNil(data?.liveImage.small)
    XCTAssertNotNil(data?.liveImage.large)
    
//    expect(data?.temperature).toEventuallyNot(beNil())
//    expect(data?.humidity).toEventuallyNot(beNil())
//    expect(data?.airPressure).toEventuallyNot(beNil())
//    expect(data?.wind).toEventuallyNot(beNil())
//    expect(data?.precipitation).toEventuallyNot(beNil())
//    expect(data?.irradiationFlux).toEventuallyNot(beNil())
//    expect(data?.measuredTime).toEventuallyNot(beNil())
//    expect(data?.liveImage.small).toEventuallyNot(beNil())
//    expect(data?.liveImage.large).toEventuallyNot(beNil())
  }
}

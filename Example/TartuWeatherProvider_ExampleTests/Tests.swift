// https://github.com/Quick/Quick

import Quick
import Nimble
import TartuWeatherProvider

class TableOfContentsSpec: QuickSpec {
  override func spec() {
    
    describe("Tartu Weather provider tests", closure: {
    
      // get current weather data
      it("Get weather data", closure: {
      
        var data:WeatherData?
        
        var error:Error?
      
        waitUntil(action: {done in
          TartuWeatherProvider.getWeatherData(completion: {result in
            data = result.value
            
            error = result.error
          
            done()
          })
        })
        
        expect(error).toEventually(beNil())
      
        expect(data?.temperature).toEventuallyNot(beNil())
        expect(data?.humidity).toEventuallyNot(beNil())
        expect(data?.airPressure).toEventuallyNot(beNil())
        expect(data?.wind).toEventuallyNot(beNil())
        expect(data?.precipitation).toEventuallyNot(beNil())
        expect(data?.irradiationFlux).toEventuallyNot(beNil())
        expect(data?.measuredTime).toEventuallyNot(beNil())
        expect(data?.liveImage.small).toEventuallyNot(beNil())
        expect(data?.liveImage.large).toEventuallyNot(beNil())
      })
    })
  }
}

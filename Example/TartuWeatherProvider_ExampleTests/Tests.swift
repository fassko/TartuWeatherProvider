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
          TartuWeatherProvider.getWeatherData(completion: {(d, e) in
            data = d
            
            error = e
          
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
      
      })
      
      // get current image from webcam
      it("Get current image from webcam", closure: {
      
        var currentImage:UIImage?
      
        waitUntil(action: {done in
          TartuWeatherProvider.getCurrentImage(completion: {(image) in
          
            currentImage = image
          
            done()
          })
        })
        
        expect(currentImage).toEventuallyNot(beNil())
      
      })
    
    })
    
  }
}

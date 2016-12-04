// https://github.com/Quick/Quick

import Quick
import Nimble
import TartuWeatherProvider

class TableOfContentsSpec: QuickSpec {
  override func spec() {
    
    describe("Tartu Weather provider tests", closure: {
    
      // get current weather data
      it("Get weather data", closure: {
      
        var temperature:String?
        var humidity:String?
        var airPressure:String?
        var wind:String?
        var precipitation:String?
        var irradiationFlux:String?
        var measuredTime:String?
        
        var error:Error?
      
        waitUntil(action: {done in
          TartuWeatherProvider.getWeatherData(completion: {(data, e) in
            temperature = data?["temperature"]
            humidity = data?["humidity"]
            airPressure = data?["airPressure"]
            wind = data?["wind"]
            precipitation = data?["precipitation"]
            irradiationFlux = data?["irradiationFlux"]
            
            error = e
            
            measuredTime = data?["measuredTime"]
          
            done()
          })
        })
        
        expect(error).toEventually(beNil())
      
        expect(temperature).toEventuallyNot(beNil())
        expect(humidity).toEventuallyNot(beNil())
        expect(airPressure).toEventuallyNot(beNil())
        expect(wind).toEventuallyNot(beNil())
        expect(precipitation).toEventuallyNot(beNil())
        expect(irradiationFlux).toEventuallyNot(beNil())
        expect(measuredTime).toEventuallyNot(beNil())
      
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

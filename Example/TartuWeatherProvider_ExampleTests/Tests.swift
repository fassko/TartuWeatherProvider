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
        var wind:String?
        var measuredTime:String?
      
        waitUntil(action: {done in
          TartuWeatherProvider.getWeatherData(completion: {(temp, w, t) in
            temperature = temp
            wind = w
            measuredTime = t
          
            done()
          })
        })
      
        expect(temperature).toEventuallyNot(beNil())
        expect(wind).toEventuallyNot(beNil())
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

//
//  TartuWeatherProvider.swift
//  Pods
//
//  Created by Kristaps Grinbergs on 02/12/2016.
//
//

import Foundation
//import UIKit

#if os(OSX)
    import AppKit
    public typealias LiveImage = NSImage
#else
    import UIKit
    public typealias LiveImage = UIImage
#endif

import Alamofire
import Fuzi
import AlamofireImage


/// Tartu Weather Provider
open class TartuWeatherProvider {

  /**
    Get weather data by parsing HTML
    
    - Parameters:
      - completion: Callback block when data is retrieved from server
      - temperature: Current temperature in Celcius
      - wind: Wind in m/s
      - measuredTime: Measured time in format: DD Mon YY HH:MI:SS
   
  */
  open class func getWeatherData(completion:@escaping (_ data:Dictionary<String, String>?, _ error:Error?) -> Void) {
    Alamofire.request("http://meteo.physic.ut.ee/en/frontmain.php?m=2").responseString(completionHandler: {
      response in
      
        switch response.result {
          
          case .failure(let error):
          
            completion(nil, error)
        
          case .success:
          
            do {
              // parse HTML file
              let document = try HTMLDocument(string: response.result.value!, encoding: String.Encoding.utf8)

              var weatherData:Dictionary<String,String> = [:]

              let elements = document.css("td > b")
              
              // temperature
              if let val = getValueFrom(elementsSet: elements, key: 0) {
                weatherData["temperature"] = val
              }
              
              // humidy
              if let val = getValueFrom(elementsSet: elements, key: 1) {
                weatherData["humidity"] = val
              }
              
              // air pressure
              if let val = getValueFrom(elementsSet: elements, key: 2) {
                weatherData["airPressure"] = val
              }
              
              // wind
              if let val = getValueFrom(elementsSet: elements, key: 3) {
                weatherData["wind"] = val
              }
              
              // precipitation
              if let val = getValueFrom(elementsSet: elements, key: 4) {
                weatherData["precipitation"] = val
              }
              
              // Irradiation flux
              if let val = getValueFrom(elementsSet: elements, key: 5) {
                weatherData["irradiationFlux"] = val
              }
              
              // get measured time
              if let val = document.css("td > small > i").first {
                weatherData["measuredTime"] = val.stringValue
              }
              
              completion(weatherData, nil)
              
            } catch let error {
            
              completion(nil, error)
              
            }
          
        }
    })
  }

  /**
    Get current weather image from webcam
    
    - Parameters:
      - completion: Callback block when data is retrieved from server
      - image: UIImage with current webcam image
   
  */
  open class func getCurrentImage(completion:@escaping (_ image:LiveImage) -> Void) {
    Alamofire.request("http://meteo.physic.ut.ee/webcam/uus/suur.jpg").responseImage { response in

      if let image = response.result.value {
        completion(image)
      }
    }
  }
  
  /**
    Get value from elements set
    
    - Parameters:
      - elementsSet: Elements set from HTMl document
      - key: Key of element
      
    - Returns: String value of element
   
  */
  class func getValueFrom(elementsSet:NodeSet, key:Int) -> String? {
    
    if elementsSet.count > key {
      return elementsSet[key].stringValue
    }
    
    return nil
  }
}

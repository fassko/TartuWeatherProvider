//
//  TartuWeatherProvider.swift
//  Pods
//
//  Created by Kristaps Grinbergs on 02/12/2016.
//
//

import Foundation
import SwiftSoup

/// Tartu Weather Provider
open class TartuWeatherProvider {

  /**
    Get weather data by parsing HTML
    
    - Parameters:
      - completion: Callback block when data is retrieved from server
      - data: Weather data struct
   
  */
  open class func getWeatherData(completion: @escaping (_ result: TartuWeatherResult<WeatherData>) -> Void) {
  
    let url = URL(string: "http://meteo.physic.ut.ee/en/frontmain.php?m=2")!
    URLSession.shared.dataTask(with: url) { data, response, error in
      DispatchQueue.main.async {
        if let error = error {
          completion(TartuWeatherResult.failure(error))
        } else if let data = data {
          do {
            let htmlString = String(data: data, encoding: .utf8)
            let doc = try SwiftSoup.parse(htmlString!)
            
            let temperature = try doc.select("body > table:nth-child(1) > tbody > tr > td > table > tbody > tr:nth-child(1) > td > table > tbody > tr > td:nth-child(2) > table > tbody > tr:nth-child(1) > td:nth-child(2) > b").text()
            let humidity = try doc.select("body > table:nth-child(1) > tbody > tr > td > table > tbody > tr:nth-child(1) > td > table > tbody > tr > td:nth-child(2) > table > tbody > tr:nth-child(2) > td:nth-child(2) > b").text()
            let airPressure = try doc.select("body > table:nth-child(1) > tbody > tr > td > table > tbody > tr:nth-child(1) > td > table > tbody > tr > td:nth-child(2) > table > tbody > tr:nth-child(3) > td:nth-child(2) > b").text()
            let wind = try doc.select("body > table:nth-child(1) > tbody > tr > td > table > tbody > tr:nth-child(1) > td > table > tbody > tr > td:nth-child(2) > table > tbody > tr:nth-child(4) > td:nth-child(2) > b").text()
            let precipitation = try doc.select("body > table:nth-child(1) > tbody > tr > td > table > tbody > tr:nth-child(1) > td > table > tbody > tr > td:nth-child(2) > table > tbody > tr:nth-child(5) > td:nth-child(2) > b").text()
            let irradiationFlux = try String(doc.select("body > table:nth-child(1) > tbody > tr > td > table > tbody > tr:nth-child(1) > td > table > tbody > tr > td:nth-child(2) > table > tbody > tr:nth-child(6) > td:nth-child(2) > b").text().dropLast()) + "^2"
            let measuredTime = try doc.select("body > table:nth-child(1) > tbody > tr > td > table > tbody > tr:nth-child(1) > td > table > tbody > tr > td:nth-child(2) > table > tbody > tr:nth-child(7) > td:nth-child(2) > small > i").text()
            
            let smallImageURL = "http://meteo.physic.ut.ee/webcam/uus/pisike.jpg"
            let largeImageURL = "http://meteo.physic.ut.ee/webcam/uus/suur.jpg"
            
            let weatherData = WeatherData(temperature: temperature, humidity: humidity, airPressure: airPressure, wind: wind, precipitation: precipitation, irradiationFlux: irradiationFlux, measuredTime: measuredTime, smallImageURL: smallImageURL, largeImageURL: largeImageURL)
            
            completion(TartuWeatherResult.success(weatherData))
            
          } catch {
            completion(TartuWeatherResult.failure(error))
          }
        }
      }
    }.resume()
  }
}

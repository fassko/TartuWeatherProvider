//
//  TartuWeatherProvider.swift
//  Pods
//
//  Created by Kristaps Grinbergs on 02/12/2016.
//
//

import Foundation
import SwiftSoup

public protocol TartuWeatherProviderProtocol {
  /// Get weather data by parsing HTML
  ///
  /// - Parameter completion: Callback block when data is retrieved from server
  static func getWeatherData(completion: @escaping (
    _ result: TartuWeatherResult<WeatherData, TartuWeatherError>) -> Void)
  
  /// Get historical data for last day
  ///
  /// - Parameters:
  ///   - dataType: Archive data type
  ///   - completion: Callback block when data is retrieved from server
  static func getArchiveData(
    _ dataType: QueryDataType,
    completion: @escaping (_ result: TartuWeatherResult<[QueryData], TartuWeatherError>) -> Void)
}

/// Tartu Weather Provider
public struct TartuWeatherProvider: TartuWeatherProviderProtocol {

  public static func getWeatherData(
    completion: @escaping (_ result: TartuWeatherResult<WeatherData, TartuWeatherError>) -> Void) {
  
    let url = URL(string: "http://meteo.physic.ut.ee/en/frontmain.php?m=2")!
    let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
    
    URLSession.shared.dataTask(with: request) { data, _, error in
      DispatchQueue.main.async {
        if let error = error {
          completion(TartuWeatherResult.failure(.error(error)))
        } else if let data = data {
          do {
            let htmlString = String(data: data, encoding: .utf8)
            let doc = try SwiftSoup.parse(htmlString!)
            
            // swiftlint:disable line_length
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
            completion(TartuWeatherResult.failure(.error(error)))
          }
        }
      }
    }.resume()
  }
  
  public static func getArchiveData(_ dataType: QueryDataType, completion: @escaping (_ result: TartuWeatherResult<[QueryData], TartuWeatherError>) -> Void) {
    
    let urlComponents = generateURLComponents(dataType: dataType)
    let request = URLRequest(url: urlComponents.url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
    
    URLSession.shared.dataTask(with: request) { data, _, error in
      DispatchQueue.main.async {
        if let error = error {
          completion(TartuWeatherResult.failure(.error(error)))
        } else if let data = data, let csvString = String(data: data, encoding: .utf8) {
         
          let lines = csvString.components(separatedBy: .newlines)
          let rawData = Array(lines.map({
            $0.components(separatedBy: ", ")
          }).dropFirst().dropLast())
          
          let queryData = rawData.map({ dataItem -> QueryData in
            QueryData(measuredTime: dataItem[0], temperature: dataItem[1], humidity: dataItem[2], airPressure: dataItem[3], wind: dataItem[4], windDirection: dataItem[5], precipitation: dataItem[6], uvIndex: dataItem[7], light: dataItem[8], irradiationFlux: dataItem[9], gammaRadiation: dataItem[10])
          })
          
          completion(TartuWeatherResult.success(queryData))
        }
      }
    }.resume()
  }
  
  /// Generate URL components from data type
  ///
  /// - Parameter dataType: Query data type
  /// - Returns: Generated URL components
  private static func generateURLComponents(dataType: QueryDataType) -> URLComponents {
    var urlComponents = URLComponents(string: "http://meteo.physic.ut.ee/en/archive.php")
    
    var end: Date
    var start: Date
    let calendar = Calendar.current
    
    switch dataType {
    case .today:
      start = Date()
      end = calendar.date(byAdding: .day, value: +1, to: start)!
    case .yesterday:
      end = Date()
      start = calendar.date(byAdding: .day, value: -1, to: end)!
    }
    
    urlComponents?.queryItems = [
      URLQueryItem(name: "do", value: "data"),
      URLQueryItem(name: "begin[year]", value: String( calendar.component(.year, from: start))),
      URLQueryItem(name: "begin[mon]", value: String(calendar.component(.month, from: start))),
      URLQueryItem(name: "begin[mday]", value: String(calendar.component(.day, from: start))),
      URLQueryItem(name: "end[year]", value: String( calendar.component(.year, from: end))),
      URLQueryItem(name: "end[mon]", value: String(calendar.component(.month, from: end))),
      URLQueryItem(name: "end[mday]", value: String(calendar.component(.day, from: end))),
      URLQueryItem(name: "ok", value: "+Query+"),
      URLQueryItem(name: "9", value: "1"),
      URLQueryItem(name: "10", value: "1"),
      URLQueryItem(name: "11", value: "1"),
      URLQueryItem(name: "12", value: "1"),
      URLQueryItem(name: "13", value: "1"),
      URLQueryItem(name: "14", value: "1"),
      URLQueryItem(name: "15", value: "1"),
      URLQueryItem(name: "16", value: "1"),
      URLQueryItem(name: "17", value: "1")
    ]
    
    return urlComponents!
  }
}

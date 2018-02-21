//
//  QueryData.swift
//  TartuWeatherProvider
//
//  Created by Kristaps Grinbergs on 21/02/2018.
//

import Foundation

/// Query data
public struct QueryData: QueryDataProtocol {
  public var measuredTime: String
  public var temperature: String
  public var humidity: String
  public var airPressure: String
  public var wind: String
  public var windDirection: String
  public var precipitation: String
  public var uvIndex: String
  public var light: String
  public var irradiationFlux: String
  public var gammaRadiation: String
}

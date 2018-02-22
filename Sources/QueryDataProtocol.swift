//
//  QueryDataProtocol.swift
//  TartuWeatherProvider
//
//  Created by Kristaps Grinbergs on 21/02/2018.
//

import Foundation

/// Query data protocol
public protocol QueryDataProtocol: WeatherDataProtocol {

  /// UV Index
  var uvIndex: String { get }

  /// Light
  var light: String { get }
  
  /// Gamma radiation
  var gammaRadiation: String { get }
}

public extension QueryDataProtocol {

  /// Measured date
  public var measuredDate: Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
    
    return dateFormatter.date(from: measuredTime)
  }
}

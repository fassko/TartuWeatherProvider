//
//  MeasureDateable.swift
//  Pods-TartuWeatherProvider_Example
//
//  Created by Kristaps Grinbergs on 23/02/2018.
//

import Foundation

/// Measure date protocol
public protocol MeasureDateable {}

public extension MeasureDateable where Self == WeatherData {
  
  /// Measured date
  var measuredDate: Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "EET")
    dateFormatter.dateFormat = "dd MMM yy HH:mm:ss"
    
    return dateFormatter.date(from: self.measuredTime)
  }
}

public extension MeasureDateable where Self == QueryData {
  
  /// Measured date
  var measuredDate: Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "EET")
    dateFormatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
    
    return dateFormatter.date(from: self.measuredTime)
  }
}

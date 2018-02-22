//
//  QueryDataType.swift
//  TartuWeatherProvider
//
//  Created by Kristaps Grinbergs on 21/02/2018.
//

import Foundation

/// Query data type
public enum QueryDataType: String, CustomStringConvertible {

  /// Today
  case today
  
  /// Yesterday
  case yesterday
  
  /// Description string convertable
  public var description: String {
    switch self {
    case .today:
      return "Today"
    case .yesterday:
      return "Yesterday"
    }
  }
}

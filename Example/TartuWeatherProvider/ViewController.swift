//
//  ViewController.swift
//  TartuWeatherProvider
//
//  Created by Kristaps Grinbergs on 12/02/2016.
//  Copyright (c) 2016 Kristaps Grinbergs. All rights reserved.
//

import UIKit

import TartuWeatherProvider

class ViewController: UIViewController {

  @IBOutlet var temperatureLabel: UILabel!
  @IBOutlet var windLabel: UILabel!
  @IBOutlet var lastMeasuredLabel: UILabel!
  @IBOutlet var currentImage: UIImageView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    getData()
  }
  
  /**
    Get weather data from provider
   
  */
  func getData() {
  
    // Get weather data
    TartuWeatherProvider.getWeatherData(completion: {data, error in
      if error == nil {
        self.temperatureLabel.text = data?.temperature
        self.windLabel.text = data?.wind
        self.lastMeasuredLabel.text = data?.measuredTime
      }
    })
    
    // Get current image
    TartuWeatherProvider.getCurrentImage(completion: {(image, error) in
      if error == nil {
        self.currentImage.image = image
      }
    })
  }
  
  /**
    Refresh weather data
    
    - Parameters:
      - sender: Action sender (UIButton)
   
  */
  @IBAction func refresh(_ sender: Any) {
    getData()
  }
}


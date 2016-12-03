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
  
    // Get weather data
    TartuWeatherProvider.getWeatherData(completion: {(temperature, wind, lastMeasured) in
    
      self.temperatureLabel.text = temperature
      self.windLabel.text = wind
      self.lastMeasuredLabel.text = lastMeasured
    })
    
    // Get current image
    TartuWeatherProvider.getCurrentImage(completion: {(image) in
      self.currentImage.image = image
    })

  }

}


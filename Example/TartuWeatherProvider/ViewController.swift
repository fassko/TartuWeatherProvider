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
    TartuWeatherProvider.getWeatherData { result in
      switch result {
        case .failure(let error):
          print("Can't get Weather Data \(error)")
        
        case .success(let data):
        
          self.temperatureLabel.text = data.temperature
          self.windLabel.text = "\(data.windDirection) \(data.wind)"
          self.lastMeasuredLabel.text = data.measuredTime
          self.setImage(url: data.liveImage.large)
      }
    }
  }
  
  /**
    Set live image
  */
  func setImage(url: String) {
    URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
      guard let imgData = data else { return }
      
      DispatchQueue.main.async {
        self.currentImage.image = UIImage(data: imgData)!
      }
    }.resume()
  }
  
  /**
    Refresh weather data
    
    - Parameters:
      - sender: Action sender (UIButton)
   
  */
  @IBAction func refresh(_ sender: Any) {
    getData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let vc = segue.destination as! HistoryTableViewController
    
    if segue.identifier == "yestreday" {
      vc.queryType = .yesterday
    } else if segue.identifier == "today" {
      vc.queryType = .today
    }
    
    (sender as! UIBarButtonItem).style = .done
  }
}


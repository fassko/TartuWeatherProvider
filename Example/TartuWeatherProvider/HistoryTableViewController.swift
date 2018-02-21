//
//  HistoryTableViewController.swift
//  TartuWeatherProvider_Example
//
//  Created by Kristaps Grinbergs on 21/02/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

import TartuWeatherProvider

class HistoryTableViewController: UITableViewController {

  var historyData =  [QueryData]()
  
  var queryType: QueryDataType = .today

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = queryType.description
    
    TartuWeatherProvider.getArchiveData(queryType) { result in
      switch result {
      case let .failure(error):
        print("Can't get query data \(error)")
        
      case let .success(data):
        self.historyData = data
        self.tableView.reloadData()
      }
    }
  }
    
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return historyData.count
  }

  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    let data = historyData[indexPath.row]
    
    cell.textLabel?.text = data.measuredTime
    cell.detailTextLabel?.text = data.temperature
    
    return cell
  }
}

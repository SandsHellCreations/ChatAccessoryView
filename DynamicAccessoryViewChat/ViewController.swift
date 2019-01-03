//
//  ViewController.swift
//  DynamicAccessoryViewChat
//
//  Created by MAC_MINI_6 on 05/06/18.
//  Copyright © 2018 MAC_MINI_6. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableViewOutlet: ChatTable! {
    didSet {
      tableViewOutlet.delegate = self
      tableViewOutlet.dataSource = self
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableViewOutlet.becomeFirstResponder()
  }
}
//MARK:- TableView Delegate and datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 30
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell  = tableViewOutlet.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as? ChatCell else {
      return UITableViewCell()
    }
    return cell
  }
}


//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class TableOfElementsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var elements = [Element]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
  override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
    tableView.dataSource = self
  }
    func loadData() {
        ElementsAPIClient.getElements { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "App Error", message: "\(appError)")
                }
            case .success(let elements):
                DispatchQueue.main.async {
                    self?.elements = elements.sorted {$0.number < $1.number}
                }
            }
        }
    }

}

extension TableOfElementsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementCell else {
            fatalError("issue with cell")
        }
        
        let element = elements[indexPath.row]
        
        cell.configureCell(for: element)
        
        return cell
    }
}

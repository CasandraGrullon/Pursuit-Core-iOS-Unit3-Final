//
//  ElementDetailVC.swift
//  Elements
//
//  Created by casandra grullon on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailVC: UIViewController {
    
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var atomicMassLabel: UILabel!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    @IBOutlet weak var discoveredByLabel: UILabel!
    
    var element: Element?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let element = element else {
            return
        }
        navigationItem.title = element.name
        symbolLabel.text = element.symbol
        numberLabel.text = element.number.description
        atomicMassLabel.text = "\(element.atomicMass ?? 0.0)"
        meltingPointLabel.text = "\(element.meltingPoint ?? 0.0)"
        boilingPointLabel.text = "\(element.boilingPoint ?? 0.0)"
        discoveredByLabel.text = "\(element.discoveredBy ?? "unknown")"
        
        elementImage.getImage(with: "http://images-of-elements.com/\(element.name.lowercased()).jpg") { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.elementImage.image = UIImage(systemName: "square.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.elementImage.image = image
                }
            }
        }
    }
    
    @IBAction func addToFaves(_ sender: UIBarButtonItem) {
        guard let element = element else {
            return
        }
        //let randomNumber = Int.random(in: 1...100)
        
        let favorite = Element(name: element.name, atomicMass: element.atomicMass, boilingPoint: element.boilingPoint, meltingPoint: element.meltingPoint, discoveredBy: element.discoveredBy, number: element.number, symbol: element.symbol, favoritedBy: "Casandra")
        
        ElementsAPIClient.postFaves(favorite: favorite) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.showAlert(title: "App Error", message: "could not add to favorites at this time")
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "♥️", message: "element was added to your favorites!")
                }
            }
        }
    }
    
    
}

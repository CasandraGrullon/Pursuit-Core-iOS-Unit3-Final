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
        atomicMassLabel.text = "atomic mass: \(element.atomicMass)"
        meltingPointLabel.text = "melting point: \(element.meltingPoint ?? 0.0)"
        boilingPointLabel.text = "boiling point: \(element.boilingPoint ?? 0.0)"
        discoveredByLabel.text = "discovered by: \(element.discoveredBy ?? "")"
        
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
    
}

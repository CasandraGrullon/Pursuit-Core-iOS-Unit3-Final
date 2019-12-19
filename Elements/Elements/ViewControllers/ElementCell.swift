//
//  ElementCell.swift
//  Elements
//
//  Created by casandra grullon on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementCell: UITableViewCell {

    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var elementName: UILabel!
    @IBOutlet weak var elementDetails: UILabel!
    
    var element: Element?
    
    func getNumber(for element: Element) -> String {
        var numberString = String()
        
        if element.number.description.count == 1 {
            numberString = "00\(element.number)"
        } else if element.number.description.count < 100 {
            numberString = "0\(element.number)"
        } else if element.number.description.count == 100 {
            numberString = "\(element.number)"
        }
        return numberString
    }
    
    func configureCell(for element: Element) {
        elementName.text = element.name
        elementDetails.text = "\(element.symbol) (\(element.number)) \(element.atomicMass)"
        
        let elementNumber = getNumber(for: element)
        print(elementNumber)
        
        elementImage.getImage(with: "http://www.theodoregray.com/periodictable/Tiles/\(elementNumber)/s7.JPG") { [weak self] (result) in
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

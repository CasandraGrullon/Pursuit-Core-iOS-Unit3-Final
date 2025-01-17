//
//  Element.swift
//  Elements
//
//  Created by casandra grullon on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Element: Codable {
    let name: String
    let atomicMass: Double?
    let boilingPoint: Double?
    let meltingPoint: Double?
    let discoveredBy: String?
    let number: Int
    let symbol: String
    let favoritedBy: String?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case atomicMass = "atomic_mass"
        case boilingPoint = "boil"
        case meltingPoint = "melt"
        case discoveredBy = "discovered_by"
        case number
        case symbol
        case favoritedBy
    }
}

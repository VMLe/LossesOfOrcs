//
//  Personnel.swift
//  LossesOfOrcs
//
//  Created by Vitalii Levchenko on 20.07.2022.
//

import Foundation

struct Personnel: Decodable {
    let date: Date?
    let day: Int?
    let personnel: Int?
    let personnelClarification: String?
    let prisonerOfWar: Int?
    
    enum CodingKeys: String, CodingKey {
        case date, day, personnel
        case personnelClarification = "personnel*"
        case prisonerOfWar = "POW"
    }
}

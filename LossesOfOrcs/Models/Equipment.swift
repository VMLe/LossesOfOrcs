//
//  Equipment.swift
//  LossesOfOrcs
//
//  Created by Vitalii Levchenko on 20.07.2022.
//

import Foundation

struct Equipment: Decodable {
    let date: Date?
    let day: Int?
    let aircraft: Int?
    let helicopter: Int?
    let tank: Int?
    let armoredPersonnelCarrier: Int?
    let fieldArtillery: Int?
    let multipleRocketLauncher: Int?
    let militaryAuto: Int?
    let fuelTank: Int?
    let drone: Int?
    let navalShip: Int?
    let antiAircraftWarfare: Int?
    let specialEquipment: Int?
    let mobileSRBMSystem: Int?
    let vehiclesAndFuelTanks: Int?
    let cruiseMissiles: Int?
    let greatestLossesDirection: String?
    
    
    enum CodingKeys: String, CodingKey {
        case date, day, aircraft, helicopter, tank
        case armoredPersonnelCarrier = "APC"
        case fieldArtillery = "field artillery"
        case multipleRocketLauncher = "MRL"
        case militaryAuto = "military auto"
        case fuelTank = "fuel tank"
        case drone
        case navalShip = "naval ship"
        case antiAircraftWarfare = "anti-aircraft warfare"
        case specialEquipment = "special equipment"
        case mobileSRBMSystem = "mobile SRBM system"
        case vehiclesAndFuelTanks = "vehicles and fuel tanks"
        case cruiseMissiles = "cruise missiles"
        case greatestLossesDirection = "greatest losses direction"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.date = try container.decode(Date.self, forKey: .date)
        self.day = try? container.decodeIfPresent(Int.self, forKey: .day)
        self.aircraft = try? container.decodeIfPresent(Int.self, forKey: .aircraft) ?? 0
        self.helicopter = try? container.decodeIfPresent(Int.self, forKey: .helicopter)
        self.tank = try? container.decodeIfPresent(Int.self, forKey: .tank)
        self.armoredPersonnelCarrier = try? container.decodeIfPresent(Int.self, forKey: .armoredPersonnelCarrier)
        self.fieldArtillery = try? container.decodeIfPresent(Int.self, forKey: .fieldArtillery)
        self.multipleRocketLauncher = try? container.decodeIfPresent(Int.self, forKey: .multipleRocketLauncher)
        self.militaryAuto = try? container.decodeIfPresent(Int.self, forKey: .militaryAuto) ?? 0
        self.fuelTank = try? container.decodeIfPresent(Int.self, forKey: .fuelTank) ?? 0
        self.drone = try? container.decodeIfPresent(Int.self, forKey: .drone)
        self.navalShip = try? container.decodeIfPresent(Int.self, forKey: .navalShip)
        self.antiAircraftWarfare = try? container.decodeIfPresent(Int.self, forKey: .antiAircraftWarfare)
        self.specialEquipment = try? container.decodeIfPresent(Int.self, forKey: .specialEquipment)
        self.mobileSRBMSystem = try? container.decodeIfPresent(Int.self, forKey: .mobileSRBMSystem)
        self.vehiclesAndFuelTanks = try? container.decodeIfPresent(Int.self, forKey: .vehiclesAndFuelTanks)
        self.cruiseMissiles = try? container.decodeIfPresent(Int.self, forKey: .cruiseMissiles)
        self.greatestLossesDirection = try? container.decodeIfPresent(String.self, forKey:.greatestLossesDirection)
      }
}

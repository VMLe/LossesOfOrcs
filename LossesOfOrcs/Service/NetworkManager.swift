//
//  NetworkManager.swift
//  LossesOfOrcs
//
//  Created by Vitalii Levchenko on 20.07.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    // MARK: - Private properties
    
    private let apiEquipment = "https://raw.githubusercontent.com/PetroIvaniuk/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_equipment.json"
    private let apiPersonnel = "https://raw.githubusercontent.com/PetroIvaniuk/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_personnel.json"
    
    // MARK: - Functions
    
    func fetchEquipmentData(completion: @escaping (_ equipment: [Equipment]) -> Void) {
        guard let url = URL(string: apiEquipment) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "Some problem with equipment data")
                return
            }
            // catch NaN in JSON
            let JsonStr = String(decoding: data, as: UTF8.self)
            let correctedJsonStr = JsonStr.replacingOccurrences(of: "NaN", with: "0")
            let correctedData = Data(correctedJsonStr.utf8)
            
            do {let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let equipment = try decoder.decode([Equipment].self, from: correctedData)
                DispatchQueue.main.async {
                    completion(equipment)
                }
            } catch let error {
                print("Error serialization json equipment", error)
            }
        }.resume()
    }
    
    func fetchPersonnelData(completion: @escaping (_ personnel: [Personnel]) -> Void) {
        guard let url = URL(string: apiPersonnel) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "Some problem with personnel data")
                return
            }
            do {let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let personnel = try decoder.decode([Personnel].self, from: data)
                DispatchQueue.main.async {
                    completion(personnel)
                }
            } catch let error {
                print("Error serialization json personnel", error)
            }
        }.resume()
    }
    
}

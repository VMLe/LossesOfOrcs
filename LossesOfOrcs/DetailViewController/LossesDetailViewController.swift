//
//  LossesDetailViewController.swift
//  LossesOfOrcs
//
//  Created by Vitalii Levchenko on 20.07.2022.
//

import UIKit

class LossesDetailViewController: UIViewController{
    
    //MARK: - Public properties
    
    var equipment: Equipment!
    var personnel: Personnel!
    var personnelOfYesterday: Personnel!
    var equipmentOfYesterday: Equipment!
    var isFirstDay : Bool!
    
    //MARK: - Private properties
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.clear
        table.separatorStyle = .singleLine
        table.separatorInset = .zero
        table.separatorColor = .systemGray5
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let greatestLossesDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let greatestLossesDirectionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: "map")
        view.image = image
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    private let equipmentDescription: [String] = ["Personnel",
                                                  "Aircrafts",
                                                  "Helicopters",
                                                  "Tanks",
                                                  "Armoured personnel carriers",
                                                  "Artillery systems",
                                                  "Multiply rocket launchers",
                                                  "Drones",
                                                  "Naval ships",
                                                  "Anti-aircraft warfare systems",
                                                  "Speciant equipments",
                                                  "Vehicles and fuel tanks",
                                                  "Cruise missiles"]
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        
        setupBackground()
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: - Private funcs
    
    private func arrayOfEquipmentProperties(equipment: Equipment, personnel: Personnel) -> [Int] {
        let cruiseMissiles = (equipment.cruiseMissiles ?? 0) + (equipment.mobileSRBMSystem ?? 0)
        let vehiclesAndFuelTanks = (equipment.vehiclesAndFuelTanks ?? 0) + (equipment.fuelTank ?? 0) + (equipment.militaryAuto ?? 0)
        
        let resultArray: [Int] = [personnel.personnel,
                                   equipment.aircraft,
                                   equipment.helicopter,
                                   equipment.tank,
                                   equipment.armoredPersonnelCarrier,
                                   equipment.fieldArtillery,
                                   equipment.multipleRocketLauncher,
                                   equipment.drone,
                                   equipment.navalShip,
                                   equipment.antiAircraftWarfare,
                                   equipment.specialEquipment,
                                   vehiclesAndFuelTanks,
                                   cruiseMissiles].map { $0 ?? 0 }
        return resultArray
    }
    
    private func gainPerDayArray () -> [Int] {

        let increaseCountArray: [Int]
        let totalEquipment = arrayOfEquipmentProperties(equipment: equipment,
                                                        personnel: personnel)
        if isFirstDay {
            increaseCountArray = totalEquipment
        } else {
            let yesterdayArrayOfEquipmentProperties = arrayOfEquipmentProperties(equipment: equipmentOfYesterday,
                                                                                 personnel: personnelOfYesterday)
            
            increaseCountArray = zip(totalEquipment, yesterdayArrayOfEquipmentProperties).map(-)
        }
        return increaseCountArray
    }
    
    private func convertDateToString(_ date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MMM dd"
        guard let date = date else { return "" }
        let result: String = dateFormatter.string(from: date)
        return result
    }
    
    private func setupBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "appBackground")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        view.insertSubview(backgroundImage, at: 0)
    }
    
    private func setupSubviews() {
        view.addSubview(imageView)
        view.addSubview(tableView)
        view.addSubview(dateLabel)
        view.addSubview(dayLabel)
        view.addSubview(greatestLossesDescriptionLabel)
        view.addSubview(greatestLossesDirectionLabel)
        
        tableView.rowHeight = 40
        tableView.register(LossesDetailCell.self, forCellReuseIdentifier: LossesDetailCell.identifier)
        
        dateLabel.text = convertDateToString(equipment.date)
        dayLabel.text = "\(equipment.day ?? 0) \n day of war"
        if let direction = equipment.greatestLossesDirection {
            greatestLossesDescriptionLabel.text = "Greatest losses direction: "
            greatestLossesDirectionLabel.text = "\(direction)"
        }
    }
    
    private func setupConstraints() {
        
        dateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -16).isActive = true
        
        dayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 15).isActive = true
        dayLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true

        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -35).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        
        greatestLossesDescriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        greatestLossesDescriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        greatestLossesDescriptionLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 1/2).isActive = true
        
        greatestLossesDirectionLabel.leftAnchor.constraint(equalTo: greatestLossesDescriptionLabel.rightAnchor).isActive = true
        greatestLossesDirectionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        greatestLossesDirectionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2, constant: -32).isActive = true

        tableView.topAnchor.constraint(equalTo: greatestLossesDirectionLabel.bottomAnchor, constant: 12).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

}

    // MARK: - UITableViewDataSource

extension LossesDetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return equipmentDescription.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LossesDetailCell.identifier, for: indexPath) as! LossesDetailCell
        let equipmentProperties = arrayOfEquipmentProperties(equipment: equipment,
                                                             personnel: personnel)
        let gainPerDayArray = gainPerDayArray()
        cell.descriptionLabel.text = equipmentDescription[indexPath.row]
        cell.countLabel.text = "\(equipmentProperties[indexPath.row])"
        cell.increaseLabel.text = " (+\(gainPerDayArray[indexPath.row]))"
        return cell
    }
}



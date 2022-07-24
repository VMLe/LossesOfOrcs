/// Copyright (c) 2022 Vitalii Levchenko
///
///THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
///INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
///AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
///DAMAGES, OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
///OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
///
//  LossesViewController.swift
//  LossesOfOrcs
//
//  Created by Vitalii Levchenko on 20.07.2022.
//

import UIKit

class LossesViewController: UICollectionViewController {

    //MARK: - Private properties
    
    private var equipment: [Equipment] = []
    private var personnel: [Personnel] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(LossesRegularCell.self,
                                forCellWithReuseIdentifier: LossesRegularCell.identifier)
        collectionView.register(LossesHeaderCell.self,
                                forCellWithReuseIdentifier: LossesHeaderCell.identifier)
        fetchData()
        setupNavigationBar()
        setupBackground()
    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if equipment.count > 10 && personnel.count > 10 {
            return personnel.count
        } else {
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let equipment = equipment[indexPath.item]
        let personnel = personnel[indexPath.item]
        let totalEquipment = totalEquipmentLosses(equipment: equipment)
        let increaseEquipment = gainPerDayEquipment(itemOfIndexPath: indexPath.item)
        let increasePersonnel = gainPerDayPersonnel(itemOfIndexPath: indexPath.item)
        
        if indexPath.item == 0 {
            let headerCell = collectionView.dequeueReusableCell(withReuseIdentifier: LossesHeaderCell.identifier, for: indexPath) as! LossesHeaderCell
            headerCell.dayLabel.text = "\(personnel.day ?? 0) day of war"
            headerCell.dateLabel.text = convertDateToString(personnel.date)
            headerCell.personnelLabel.attributedText = addAttribute(description: "Personnel losses \(personnel.personnelClarification ?? ""):",
                                                                    amount: personnel.personnel,
                                                                    gain: increasePersonnel)
            headerCell.equipmentLabel.attributedText = addAttribute(description: "Total equipment losses:",
                                                                   amount: totalEquipment,
                                                                   gain: increaseEquipment)
            headerCell.greatestLossesDescriptionLabel.text = "Area of greatest loss: "
            headerCell.greatestLossesDirectionLabel.text = "\(equipment.greatestLossesDirection ?? "")"

            
            return headerCell
            } else {
                let regularCell = collectionView.dequeueReusableCell(withReuseIdentifier: LossesRegularCell.identifier , for: indexPath) as! LossesRegularCell
                regularCell.dateLabel.text = convertDateToString(personnel.date, isShort: true)
                regularCell.personnelLabel.text = "Personnel \(personnel.personnelClarification ?? ""):"
                regularCell.personnelCountLabel.attributedText = addAttribute(amount: personnel.personnel,
                                                                              gain: increasePersonnel)
                regularCell.equipmentLabel.text = "Total equipment:"
                regularCell.equipmentCountLabel.attributedText = addAttribute(amount: totalEquipment,
                                                                              gain: increaseEquipment)
                return regularCell
            }
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let detailVC = LossesDetailViewController()
        
        detailVC.personnel = personnel[indexPath.item]
        detailVC.equipment = equipment[indexPath.item]
        
        if indexPath.item < equipment.count - 1 {
            detailVC.personnelOfYesterday = personnel[indexPath.item + 1]
            detailVC.equipmentOfYesterday = equipment[indexPath.item + 1]
            detailVC.isFirstDay = false
        } else {
            detailVC.personnelOfYesterday = personnel[indexPath.item]
            detailVC.equipmentOfYesterday = equipment[indexPath.item]
            detailVC.isFirstDay = true
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Private functions
    
    private func fetchData() {
        NetworkManager.shared.fetchEquipmentData() { equipment in
            self.equipment = equipment.reversed()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        NetworkManager.shared.fetchPersonnelData() { personnel in
            self.personnel = personnel.reversed()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Orcs` combat losses"
    
        let navBarStandartAppearance = UINavigationBarAppearance()
        navBarStandartAppearance.configureWithOpaqueBackground()
        navBarStandartAppearance.backgroundColor = .clear
        navBarStandartAppearance.shadowColor = .clear
        navBarStandartAppearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        navBarStandartAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemGray6]

        navigationController?.navigationBar.tintColor = .systemGray6
        navigationController?.navigationBar.standardAppearance = navBarStandartAppearance
    }
    
    private func setupBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "appBackground")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        collectionView.backgroundView = backgroundImage
    }
    
    private func convertDateToString(_ date: Date?,isShort style: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        if style {
            dateFormatter.dateFormat = "MMM dd"
        } else {
            dateFormatter.dateFormat = "MMM dd, yyyy"
        }
        guard let date = date else { return ""}
        let result: String = dateFormatter.string(from: date)
        return result
    }
    
    private func addAttribute(description string: String? = nil,
                              amount parametr: Int?,
                              gain increase: Int?) -> NSMutableAttributedString {
        
        let attributeDescription = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18),
                            NSAttributedString.Key.foregroundColor : UIColor.white]

        let attributeAmount = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18),
                            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)]
    
        let attributeGain = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14),
                            NSAttributedString.Key.foregroundColor :  #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]

        let attributedDescriptionString = NSMutableAttributedString(string: string ?? "",
                                                          attributes: attributeDescription)

        let attributedAmountString = NSMutableAttributedString(string: " \(parametr ?? 0)",
                                                          attributes: attributeAmount)
        
        let attributedGainString = NSMutableAttributedString(string: " (+\(increase ?? 0))",
                                                          attributes: attributeGain)
        attributedDescriptionString.append(attributedAmountString)
        attributedDescriptionString.append(attributedGainString)
        
        return attributedDescriptionString
    }
    
    private func totalEquipmentLosses(equipment: Equipment) -> Int {
        var totalOfEquipment = 0
        let _ = [equipment.aircraft,
                 equipment.helicopter,
                 equipment.tank,
                 equipment.armoredPersonnelCarrier,
                 equipment.fieldArtillery,
                 equipment.multipleRocketLauncher,
                 equipment.drone,
                 equipment.navalShip,
                 equipment.antiAircraftWarfare,
                 equipment.specialEquipment,
                 equipment.vehiclesAndFuelTanks,
                 equipment.fuelTank,
                 equipment.militaryAuto,
                 equipment.cruiseMissiles,
                 equipment.mobileSRBMSystem].map { totalOfEquipment += ($0 ?? 0)}
        return totalOfEquipment
    }
    
    private func gainPerDayEquipment(itemOfIndexPath indexPath: Int) -> Int {
        let increaseEquipment : Int
        let totalEquipment = totalEquipmentLosses(equipment: equipment[indexPath])
        
        if indexPath < equipment.count - 1 {
            increaseEquipment = totalEquipment - totalEquipmentLosses(equipment: equipment[indexPath + 1])
        } else {
            increaseEquipment = totalEquipment
        }
        return increaseEquipment
    }
    
    private func gainPerDayPersonnel(itemOfIndexPath indexPath: Int) -> Int {
        let increasePersonnel : Int
        let totalPersonnel = personnel[indexPath].personnel ?? 0
        
        if indexPath < equipment.count - 1 {
            increasePersonnel = totalPersonnel - (personnel[indexPath + 1].personnel ?? 0)
        } else {
            increasePersonnel = totalPersonnel
        }
        return increasePersonnel
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension LossesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 240)
        } else {
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 120)
        }
    }
    
}

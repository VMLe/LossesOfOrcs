//
//  LossesRegularCell.swift
//  LossesOfOrcs
//
//  Created by Vitalii Levchenko on 20.07.2022.
//

import UIKit

class LossesRegularCell: UICollectionViewCell {
    
    // MARK: - Public properties
    
    static let identifier = "LossesRegularCell"
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let personnelLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .systemGray6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let personnelCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let equipmentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .systemGray6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let equipmentCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Private properties
    
    private let chevronImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .init(white: 0.8, alpha: 0.4)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Construction
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupView() {
        backgroundColor = .init(white: 0.2, alpha: 0.4)
        layer.cornerRadius = 20
        contentView.addSubview(dateLabel)
        contentView.addSubview(personnelLabel)
        contentView.addSubview(personnelCountLabel)
        contentView.addSubview(equipmentLabel)
        contentView.addSubview(equipmentCountLabel)
        contentView.addSubview(chevronImageView)
    }
    
    private func setupConstraints() {
        
        dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2, constant: -24).isActive = true
        
        chevronImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        personnelLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        personnelLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -12).isActive = true
        
        personnelCountLabel.leftAnchor.constraint(equalTo: personnelLabel.rightAnchor).isActive = true
        personnelCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -12).isActive = true
        personnelCountLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3).isActive = true
        
        equipmentLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        equipmentLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20).isActive = true
        
        equipmentCountLabel.leftAnchor.constraint(equalTo: personnelLabel.rightAnchor).isActive = true
        equipmentCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20).isActive = true
        equipmentCountLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3).isActive = true
    }
}

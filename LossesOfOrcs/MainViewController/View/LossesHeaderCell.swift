//
//  LossesHeaderCell.swift
//  LossesOfOrcs
//
//  Created by Vitalii Levchenko on 20.07.2022.
//

import UIKit

class LossesHeaderCell: UICollectionViewCell {
    
    // MARK: - Public properties
    
    static let identifier = "LossesHeaderCell"
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let personnelLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let equipmentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray6
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let greatestLossesDirectionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor =  #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let greatestLossesDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .systemGray6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Private properties
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: "lineMap")
        view.image = image
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        setupConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Functions
    
    private func setupView() {
        backgroundColor = .init(white: 0.2, alpha: 0.4)
        layer.cornerRadius = 20
        contentView.insertSubview(imageView, at: 1)
        contentView.addSubview(dateLabel)
        contentView.addSubview(dayLabel)
        contentView.addSubview(personnelLabel)
        contentView.addSubview(equipmentLabel)
        contentView.addSubview(greatestLossesDescriptionLabel)
        contentView.addSubview(greatestLossesDirectionLabel)
        contentView.addSubview(chevronImageView)
    }
    
    private func setupConstaints() {
        
        dayLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        dayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        dayLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2, constant: -24).isActive = true
        
        dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2, constant: -24).isActive = true
        
        chevronImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        personnelLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        personnelLabel.bottomAnchor.constraint(equalTo: equipmentLabel.topAnchor, constant: -12).isActive = true
        
        equipmentLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        equipmentLabel.bottomAnchor.constraint(equalTo: greatestLossesDirectionLabel.topAnchor, constant: -12).isActive = true
        
        greatestLossesDescriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        greatestLossesDescriptionLabel.topAnchor.constraint(equalTo: greatestLossesDirectionLabel.topAnchor).isActive = true
        greatestLossesDescriptionLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 1/2).isActive = true
        
        greatestLossesDirectionLabel.leftAnchor.constraint(equalTo: greatestLossesDescriptionLabel.rightAnchor).isActive = true
        greatestLossesDirectionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        greatestLossesDirectionLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2, constant: -32).isActive = true
    
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
}


//
//  LossesDetailCell.swift
//  LossesOfOrcs
//
//  Created by Vitalii Levchenko on 20.07.2022.
//

import UIKit

class LossesDetailCell: UITableViewCell {
    
    // MARK: - Public properties
    
    static let identifier = "LossesDetailCell"

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemGray6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let increaseLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Construction
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)

        setupContentView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private funcs
    
    private func setupContentView() {
        backgroundColor = .init(white: 0.2, alpha: 0.4)
        selectionStyle = .none
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(increaseLabel)
    }
    
    private func setupConstraints() {
        descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2, constant: 30).isActive = true
        
        countLabel.rightAnchor.constraint(equalTo: increaseLabel.leftAnchor).isActive = true
        countLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        countLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/4, constant: -20).isActive = true
        
        increaseLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        increaseLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        increaseLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/4, constant: -40).isActive = true
    }
}


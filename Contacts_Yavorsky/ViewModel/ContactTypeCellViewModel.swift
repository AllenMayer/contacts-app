//
//  ContactTypeCellViewModel.swift
//  Contacts_Yavorsky
//
//  Created by Maxim Semeniy on 28.06.2021.
//

import UIKit

class ContactTypeCellViewModel {
    
    func configure(cell: ContactTypeCell, with model: ContactTypeModel) {
        cell.contactTypeImageView.image = UIImage(systemName: model.image)
        cell.titleLabel.text = model.titleLabel
        cell.numberLabel.text = "\(model.numberLabel)"
    }
    
    func configureCell(in contentView: UIView, cell: ContactTypeCell, contactTypeImageView: UIImageView, titleLabel: UILabel, numberLabel: UILabel) {
        contentView.addSubview(contactTypeImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(numberLabel)
        
        NSLayoutConstraint.activate([
            contactTypeImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            contactTypeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contactTypeImageView.heightAnchor.constraint(equalToConstant: 50),
            contactTypeImageView.widthAnchor.constraint(equalToConstant: 50),
            
            
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contactTypeImageView.rightAnchor, constant: 30),
            
            numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            numberLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30)
        ])
    }
}

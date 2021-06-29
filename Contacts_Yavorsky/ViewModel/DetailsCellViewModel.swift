//
//  DetailsCellViewModel.swift
//  Contacts_Yavorsky
//
//  Created by Maxim Semeniy on 29.06.2021.
//

import UIKit

class DetailsCellViewModel {
    func configure(cell: DetailsCell, with model: DetailsModel) {
        if model.name!.trimmingCharacters(in: .whitespaces).isEmpty {
            cell.nameLabel.text = "Без имени"
        } else {
            cell.nameLabel.text = model.name?.trimmingCharacters(in: .whitespaces)
        }
        cell.phoneLabel.text = model.phone
        cell.emailLabel.text = model.email
    }
    
    func configureCell(in contentView: UIView, cell: DetailsCell, nameLabel: UILabel, phoneLabel: UILabel, emailLabel: UILabel) {
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneLabel)
        contentView.addSubview(emailLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            phoneLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            
            emailLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            emailLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 10)
        ])
    }
}

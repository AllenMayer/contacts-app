//
//  DetailsCell.swift
//  Contacts_Yavorsky
//
//  Created by Maxim Semeniy on 29.06.2021.
//

import UIKit

class DetailsCell: UITableViewCell {
    static let identifier = "DetailsCell"
    
    let viewModel = DetailsCellViewModel()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        viewModel.configureCell(in: contentView, cell: self, nameLabel: nameLabel, phoneLabel: phoneLabel, emailLabel: emailLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

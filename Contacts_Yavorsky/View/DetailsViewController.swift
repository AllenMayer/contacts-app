//
//  DetailsViewController.swift
//  Contacts_Yavorsky
//
//  Created by Maxim Semeniy on 28.06.2021.
//

import UIKit
import Contacts

class DetailsViewController: UITableViewController {
    
    var contacts = [CNContact]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(DetailsCell.self, forCellReuseIdentifier: DetailsCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsCell.identifier, for: indexPath) as! DetailsCell
        let detailsModel = DetailsModel(
            name: contacts[indexPath.row].givenName + " " + contacts[indexPath.row].familyName,
            email: (contacts[indexPath.row].emailAddresses.first?.value ?? "") as String,
            phone: contacts[indexPath.row].phoneNumbers.first?.value.stringValue ?? "")
        cell.viewModel.configure(cell: cell, with: detailsModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}

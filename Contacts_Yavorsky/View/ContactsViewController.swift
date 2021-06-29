//
//  ContactsViewController.swift
//  Contacts_Yavorsky
//
//  Created by Maxim Semeniy on 28.06.2021.
//

import UIKit
import Contacts

class ContactsViewController: UITableViewController {
    
    let viewModel = ContactsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Контакты"
        
        tableView.register(ContactTypeCell.self, forCellReuseIdentifier: ContactTypeCell.identifier)
        
        //ContactsManager.shared.seedContacts()
        
        ContactsManager.shared.fetchContacts { [weak self] contacts in
            self?.viewModel.fetchNumberOfContacts(contacts: contacts)
        
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contactTypes.count
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTypeCell.identifier) as! ContactTypeCell
        let contactTypeModel = ContactTypeModel(
            image: viewModel.contactTypesImages[indexPath.row],
            titleLabel: viewModel.contactTypes[indexPath.row],
            numberLabel: viewModel.contactTuples[indexPath.row].0)
        cell.viewModel.configure(cell: cell, with: contactTypeModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailsViewController()
        vc.title = viewModel.contactTypes[indexPath.row]
        vc.contacts = viewModel.contactTuples[indexPath.row].1
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


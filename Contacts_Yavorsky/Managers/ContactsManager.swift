//
//  ContactsManager.swift
//  Contacts_Yavorsky
//
//  Created by Maxim Semeniy on 28.06.2021.
//

import UIKit
import Contacts

class ContactsManager {
    
    static let shared = ContactsManager()
    
    private init() {}
    
    func fetchContacts(completion: @escaping (([CNContact]) -> Void)) {
        var contacts = [CNContact]()
        
        let keysToFetch = [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactEmailAddressesKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor]
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
        
        fetchRequest.sortOrder = CNContactSortOrder.userDefault
        
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { granted, err in
            if let _ = err {
                print("access failed.")
                return
            }
            
            if granted {
                do {
                    try store.enumerateContacts(with: fetchRequest) { (contact, stop) in
                        contacts.append(contact)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        completion(contacts)
    }
    
    func seedContacts() {
        
        let dummyContacts = [
            ["firstName": "Simona", "lastName": "Morasca", "phoneNumber": "423-541-3953", "homeEmail": ""],
            ["firstName": "Simona", "lastName": "Morasca", "phoneNumber": "419-503-2484", "homeEmail": "simona@morasca.com"],
            ["firstName": "Simona", "lastName": "", "phoneNumber": "", "homeEmail": "simona@gmail.com.com"],
            ["firstName": "Cammy", "lastName": "Albares", "phoneNumber": "956-537-6195", "homeEmail": "calbares@gmail.com"],
            ["firstName": "Yuki", "lastName": "Whobrey", "phoneNumber": "313-288-7937", "homeEmail": "yuki_whobrey@aol.com"],
            ["firstName": "", "lastName": "Veronika", "phoneNumber": "", "homeEmail": "vinouye@aol.com"],
            ["firstName": "Jose", "lastName": "Stockham", "phoneNumber": "212-569-4233", "homeEmail": ""],
            ["firstName": "Valentine", "lastName": "Gillian", "phoneNumber": "210-300-6244", "homeEmail": "valentine_gillian@gmail.com"],
            ["firstName": "Youlanda", "lastName": "Schemmer", "phoneNumber": "541-993-2611", "homeEmail": "youlanda@aol."],
            ["firstName": "", "lastName": "", "phoneNumber": "907-335-6568", "homeEmail": ""],
        ]
        
        for (_, contactData) in dummyContacts.enumerated() {
            let contact = CNMutableContact()
            
            contact.givenName = contactData["firstName"]!
            contact.familyName = contactData["lastName"]!
            
            let homeEmail = CNLabeledValue(label: CNLabelHome, value: contactData["homeEmail"]! as NSString)
            contact.emailAddresses = [homeEmail]
            
            contact.phoneNumbers = [CNLabeledValue(
                                        label: CNLabelPhoneNumberiPhone,
                                        value: CNPhoneNumber(stringValue: contactData["phoneNumber"]!))]
            
            let store = CNContactStore()
            let saveRequest = CNSaveRequest()
            saveRequest.add(contact, toContainerWithIdentifier: nil)
            
            do {
                try store.execute(saveRequest)
                print("contact \(contact.givenName) saved")
            } catch {
                print("Saving contact failed, error: \(error)")
            }
        }
    }
}

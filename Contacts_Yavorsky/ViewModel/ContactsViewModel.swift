//
//  ContactsViewModel.swift
//  Contacts_Yavorsky
//
//  Created by Maxim Semeniy on 28.06.2021.
//

import UIKit
import Contacts

class ContactsViewModel {
    
    var contactTypes = ["Контакты", "Повторяющиеся имена", "Дубликаты номеров", "Без имени", "Нет номера", "Нет электронной почты"]
    let contactTypesImages = ["person.3.fill", "person.2.fill", "phone.fill", "person.crop.circle.fill.badge.xmark", "iphone.homebutton.slash", "envelope.fill"]
    
    var contactTuples = [(Int, [CNContact])]()
    
    func fetchNumberOfContacts(contacts: [CNContact]) {
        contactTuples.append((contacts.count, contacts))
        
        fetchDuplicatingNamesContacts(contacts: contacts)
        fetchDuplicatingPhoneNumbersContacts(contacts: contacts)
        fetchEmptyNameContacts(contacts: contacts)
        fetchEmptyPhoneContacts(contacts: contacts)
        fetchEmptyEmailContacts(contacts: contacts)
    }
    
    private func fetchDuplicatingNamesContacts(contacts: [CNContact])  {
        let singleNames = Set(Dictionary(grouping: contacts, by: {[$0.givenName, $0.familyName]}).filter{$0.1.count == 1}.map{$0.0})
        let duplicatingNames = contacts.filter {!singleNames.contains([$0.givenName, $0.familyName])}
        
        contactTuples.append((duplicatingNames.count, duplicatingNames))
    }
    
    private func fetchDuplicatingPhoneNumbersContacts(contacts: [CNContact]) {
        let singlePhones = Set(Dictionary(grouping: contacts, by: {$0.phoneNumbers.first!.value.stringValue}).filter{$0.1.count == 1}.map{$0.0})
        let duplicatingPhones = contacts.filter {!singlePhones.contains($0.phoneNumbers.first!.value.stringValue)}
        let duplicatingPhonesExcludingEmptyPhones = duplicatingPhones.filter { $0.phoneNumbers.first?.value.stringValue != "" }
        
        contactTuples.append((duplicatingPhonesExcludingEmptyPhones.count, duplicatingPhonesExcludingEmptyPhones))
    }
    
    private func fetchEmptyNameContacts(contacts: [CNContact]) {
        let emptyNamesContacts = contacts.filter { $0.givenName == "" && $0.familyName == "" }
        contactTuples.append((emptyNamesContacts.count, emptyNamesContacts))
    }
    
    private func fetchEmptyPhoneContacts(contacts: [CNContact]) {
        let emptyPhoneContacts = contacts.filter { $0.phoneNumbers.first?.value.stringValue == "" }
        contactTuples.append((emptyPhoneContacts.count, emptyPhoneContacts))
    }
    
    private func fetchEmptyEmailContacts(contacts: [CNContact]) {
        let emptyEmailContacts = contacts.filter { $0.emailAddresses.first?.value == "" }
        contactTuples.append((emptyEmailContacts.count, emptyEmailContacts))
    }
}

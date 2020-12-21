//
//  Issue.swift
//  GithubIssues
//
//  Created by Martin Kuvandzhiev on 20.12.20.
//

import Foundation
import Realm
import RealmSwift

typealias Issues = [Issue]

class Issue: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var number: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var comments: Int = 0
    @objc dynamic var createdAt: Date = Date()
    @objc dynamic var updatedAt: Date = Date()
    @objc dynamic var body: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Issue: Identifiable {

}

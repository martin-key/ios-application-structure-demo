//
//  DataStore.swift
//  GithubIssues
//
//  Created by Martin Kuvandzhiev on 21.12.20.
//

import Foundation
import Combine

class DataStore: ObservableObject {
    static let shared = DataStore()
    
    @Published var issues: [Issue] = Array(LocalDataManager.realm.objects(Issue.self))
}

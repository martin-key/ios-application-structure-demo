//
//  LocalDataManager.swift
//  GithubIssues
//
//  Created by Martin Kuvandzhiev on 20.12.20.
//

import Foundation
import Realm
import RealmSwift

class LocalDataManager {
    static let realm: Realm = {
        return try! initializeRealm(checkForMainThread: true)
    }()
    
    class var backgroundRealm: Realm {
        return try! initializeRealm()
    }
    
    class func initializeRealm(checkForMainThread: Bool = false) throws -> Realm {
        if checkForMainThread {
            guard OperationQueue.current?.underlyingQueue == DispatchQueue.main else {
                throw LocalDataManagerError.wrongQueue
            }
        }
        do {
            return try Realm(configuration: realmConfiguration)
        } catch {
            throw error
        }
    }
    
    
    static let realmConfiguration: Realm.Configuration = {
        var configuration = Realm.Configuration.defaultConfiguration
        configuration.schemaVersion = 1
        configuration.migrationBlock = { (migration, version) in
            
        }
        
        return configuration
    }()
    
}

extension LocalDataManager {
    enum LocalDataManagerError: Error {
        case wrongQueue
    }
}

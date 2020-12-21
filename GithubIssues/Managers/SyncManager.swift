//
//  SyncManager.swift
//  GithubIssues
//
//  Created by Martin Kuvandzhiev on 20.12.20.
//

import Foundation
import Realm
import RealmSwift
import Combine

class SyncManager {
    class func loadAllData() {
        //used below iOS13
//        loadIssues()
        
        //Used with Combine
        loadIssuesCombine()
            .sink() {
                DataStore.shared.issues = $0
            }
            .store(in: &disposeBag)
    }
    
    //syncIssues
    class func loadIssues() {
        RequestManager.fetchIssues { (issues, error) in
            guard error == nil else {
                //handle the error or just
                return
            }
            
            guard let issues = issues else {
                //handle it or just
                return
            }
            
            let realm = LocalDataManager.backgroundRealm
            try? realm.write() {
                realm.add(issues, update: .all)
            }
            
            NotificationCenter.default.post(name: .issuesFetched, object: issues)
        }
    }
    
    
    //Used With Combine
    static var disposeBag: Set<AnyCancellable> = .init()
    class func loadIssuesCombine() -> Future<Issues, Never> {
        return Future() { promise in
            RequestManager.fetchIssuesCombine()
                .tryMap({ (issues) -> Issues in
                    try LocalDataManager.backgroundRealm.write {
                        LocalDataManager.backgroundRealm.add(issues, update: .all)
                    }
                    return issues
                })
                .sink { (result) in
                    // handle result
                    return
                } receiveValue: { (issues) in
                    promise(Result.success(issues))
                }.store(in: &disposeBag)
        }
    }
}

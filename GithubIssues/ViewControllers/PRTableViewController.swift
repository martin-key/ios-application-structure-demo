//
//  PRTableViewController.swift
//  GithubIssues
//
//  Created by Martin Kuvandzhiev on 20.12.20.
//

import UIKit
import Realm
import RealmSwift
import Combine

class PRTableViewController: UITableViewController {

    lazy var pullRequestsData: [Issue] = {
        return Array(LocalDataManager.realm.objects(Issue.self).sorted(byKeyPath: "id", ascending: false))
    }()
    
    var disposableBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .issuesFetched, object: nil)
        
        //if iOS 13 and above using combine
//        NotificationCenter.default.publisher(for: .issuesFetched)
//            .sink { (_) in
//            self.reloadData()
//        }.store(in: &disposableBag)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return pullRequestsData.count > 0 ? 1 : 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pullRequestsData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "prTableViewCell", for: indexPath) as? PRTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupCell(issue: self.pullRequestsData[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        UIApplication.shared.open(URL(string: self.pullRequestsData[indexPath.row].url)!, completionHandler: nil)
    }

}

extension PRTableViewController {
    @objc func reloadData() {
        pullRequestsData = Array(LocalDataManager.realm.objects(Issue.self).sorted(byKeyPath: "id", ascending: false))
        self.tableView.reloadData()
    }
}

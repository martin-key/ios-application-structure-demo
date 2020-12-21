//
//  ViewController.swift
//  GithubIssues
//
//  Created by Martin Kuvandzhiev on 20.12.20.
//

import UIKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.performSegue(withIdentifier: "toSwiftUI", sender: nil)
    }

}


//
//  PRTableViewCell.swift
//  GithubIssues
//
//  Created by Martin Kuvandzhiev on 20.12.20.
//

import UIKit

class PRTableViewCell: UITableViewCell {

    @IBOutlet weak var prNameLabel: UILabel!
    @IBOutlet weak var prIdLabel: UILabel!
    @IBOutlet weak var prDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(issue: Issue) {
        self.prNameLabel.text = issue.title
        self.prIdLabel.text = issue.number.description
        self.prDescriptionLabel.text = issue.body
    }
}

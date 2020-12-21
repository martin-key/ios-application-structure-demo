//
//  PRTableViewSwiftUI.swift
//  GithubIssues
//
//  Created by Martin Kuvandzhiev on 21.12.20.
//

import UIKit
import SwiftUI

struct PRTableViewSwiftUI: View {
    @ObservedObject var dataStore: DataStore = DataStore.shared
    var body: some View {
        List(dataStore.issues) { issue in
            PRTableViewSwiftUICell(issue: issue)
        }
    }
}

struct PRTableViewSwiftUICell: View {
    let issue: Issue
    var body: some View {
        VStack {
            HStack{
                Text(issue.title)
                Spacer()
                Text(issue.number.description)
                    .foregroundColor(Color.gray)
            }
            HStack{
                Text(issue.body)
                    .foregroundColor(Color.gray)
                    .lineLimit(2)
            Spacer()
            }

        }
    }
}

class ChildHostingController: UIHostingController<PRTableViewSwiftUI> {
    required init?(coder: NSCoder) {
        super.init(coder: coder,
                   rootView: PRTableViewSwiftUI());
        }
    
        override func viewDidLoad() {
            super.viewDidLoad()
        }
}

#if DEBUG
struct PRTableViewSwiftUI_Previews : PreviewProvider {
    static let mockData: Issue = {
        var data = Issue()
        data.title = "Some title for doing tests"
        data.body = "Some really long description different than lorem ipsum"
        data.number = 12345
        return data
    }()
    
    static var previews: some View {
        Group {
            PRTableViewSwiftUI()
        }
    }
}
#endif

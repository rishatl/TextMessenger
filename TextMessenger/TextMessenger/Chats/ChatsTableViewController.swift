//
//  MessagesTableViewController.swift
//  TextMessenger
//
//  Created by Rishat on 09.10.2021.
//

import UIKit

//MARK: - ViewController

class ChatsTableViewController: UIViewController {

    // MARK: Private properties

    private let chatCellId = "ChatCell"
    private let tableView = UITableView()

    private var chats: [ChatModelView.Chat] = [.init(image: UIImage(named: "ProfilePhoto"), firstName: "Jessica", lastName: "Thompson", description: "Hey you! Are u there?", date: "4h ago"),
                                                       .init(image: UIImage(named: "ProfilePhoto2"), firstName: "Kat", lastName: "Williams", description: "OMG! OMG! OMG!", date: "5h ago"),
                                                       .init(image: UIImage(named: "ProfilePhoto3"), firstName: "Jacob", lastName: "Washington", description: "Sure. Sunday works for me!", date: "20/9/21"),
                                                       .init(image: nil, firstName: "Leslie", lastName: "Alexander", description: "Sent you an invite for next monday.", date: "19/9/21"),
                                                       .init(image: UIImage(named: "ProfilePhoto4"), firstName: "Tony", lastName: "Monta", description: "How’s Alicia doing? Ask her to give m...", date: "19/9/21")]


    // MARK: Lifecycle

    override func viewDidLoad() {

        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

    }

    // MARK: Private

    private func chatButtonTapped() {

        let vc = ChatVC()
        navigationController?.pushViewController(vc, animated: true)

    }

}

// MARK: -UITableViewDataSource, UITableViewDelegate

extension ChatsTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chats.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: chatCellId) as? ChatTableViewCell else { return UITableViewCell() }

        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chatButtonTapped()
    }

}

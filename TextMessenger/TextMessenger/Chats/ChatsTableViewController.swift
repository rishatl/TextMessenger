//
//  MessagesTableViewController.swift
//  TextMessenger
//
//  Created by Rishat on 09.10.2021.
//

import UIKit
import SnapKit

//MARK: - ViewController

class ChatsTableViewController: UIViewController {

    // MARK: Private properties

    private let chatCellId = "ChatCell"
    private let tableView = UITableView()

    private let searchController = UISearchController(searchResultsController: nil)

    private var chats: [ChatViewModel.Chat] = [.init(image: UIImage(named: "ProfilePhoto"), firstName: "Jessica", lastName: "Thompson", description: "Hey you! Are u there?", date: "4h ago"),
                                               .init(image: UIImage(named: "ProfilePhoto2"), firstName: "Kat", lastName: "Williams", description: "OMG! OMG! OMG!", date: "5h ago"),
                                               .init(image: UIImage(named: "ProfilePhoto3"), firstName: "Jacob", lastName: "Washington", description: "Sure. Sunday works for me!", date: "20/9/21"),
                                               .init(image: nil, firstName: "Leslie", lastName: "Alexander", description: "Sent you an invite for next monday.", date: "19/9/21"),
                                               .init(image: UIImage(named: "ProfilePhoto4"), firstName: "Tony", lastName: "Monta", description: "How’s Alicia doing? Ask her to give m...", date: "19/9/21")]


    // MARK: Lifecycle

    override func viewDidLoad() {

        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        setupNavbar()
        setupTableView()

    }

    // MARK: Private

    private func setupNavbar() {

        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "MESSAGES"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchTextField.attributedPlaceholder =
            NSMutableAttributedString(string: "Who do you want to chat with?",
                                      attributes: [NSAttributedString.Key.font : UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.init(name: "Habibi-Regular", size: 17)!), .foregroundColor: UIColor(hexString: "#3C3C43")])
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

    }

    private func setupTableView() {

        view.backgroundColor = .systemBackground
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: chatCellId)
        tableView.rowHeight = UITableView.automaticDimension

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        tableView.reloadData()

    }

    private func chatButtonTapped(chat: ChatViewModel.Chat) {

        let vc = ChatVC()
        vc.configure(username: "\(chat.firstName) \(chat.lastName)", profileImage: chat.image)
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

        let chat = chats[indexPath.row]
        cell.configure(chatModel: .init(profileImage: chat.image,
                                          username: "\(chat.firstName) \(chat.lastName)",
                                          lastMessage: chat.description,
                                          date: chat.date))
        cell.separatorInset = .zero

        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let chat = chats[indexPath.row]
        chatButtonTapped(chat: chat)
        
    }

}

//
//  ViewController.swift
//  TextMessenger
//
//  Created by Rishat on 03.10.2021.
//

import UIKit

//MARK: - ViewController

class ChatVC: UIViewController {

    //MARK: - Private Properties

    private let messageCellId = "messageCell"
    private let tableView = UITableView()
    private let chatTextFieldView = ChatTextFieldView()

    //MARK: - Public Properties

    var chatMessages = [
        [
            ChatMessageViewModel(image: UIImage(named: "ProfilePhoto"), text: "Hi! I'm there", isIncoming: true, date: Date.dateFromCustomString(customString: "01/03/2021")),
            ChatMessageViewModel(image: UIImage(named: "ProfilePhoto"), text: "Alex, let’s meet this weekend. I’ll check with Dave too 😎", isIncoming: true, date: Date.dateFromCustomString(customString: "01/03/2021"))
        ],
        [
            ChatMessageViewModel(image: nil, text: "Hello, there!", isIncoming: false, date: Date.dateFromCustomString(customString: "02/01/2021")),
            ChatMessageViewModel(image: nil, text: "Sure. Let’s aim for saturday", isIncoming: false, date: Date.dateFromCustomString(customString: "02/01/2021"))
        ],
        [
            ChatMessageViewModel(image: nil, text: "I’m visiting mom this sunday 👻", isIncoming: false, date: Date.dateFromCustomString(customString: "10/02/2021"))
        ],
        [
            ChatMessageViewModel(image: UIImage(named: "ProfilePhoto"), text: "Alrighty! Will give you a call shortly 🤗", isIncoming: true, date: Date.dateFromCustomString(customString: "10/03/2021"))
        ]
    ]

    //MARK: - Lifecycle

    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .white

        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Habibi-Regular", size: 14)!]

        setupChatTextFieldView()
        setupTableView()

        chatTextFieldView.delegate = self

    }

    //MARK: - Private Methods

    private func setupTableView() {

        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: messageCellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: chatTextFieldView.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        let dummyViewHeight = CGFloat(40)
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: dummyViewHeight))
        self.tableView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: 0, right: 0)

    }

    private func setupDateContainerView(label: UILabel) -> UIView {

        let containerView = UIView()
        containerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])

        return containerView

    }

    private func setupChatTextFieldView() {

        view.addSubview(chatTextFieldView)
        chatTextFieldView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            chatTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatTextFieldView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            chatTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            chatTextFieldView.heightAnchor.constraint(equalToConstant: 88)
        ])

    }

    func configure(username: String, profileImage: UIImage?) {
        navigationItem.title = username
    }

}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ChatVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatMessages[section].count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if let firstMessageInSection = chatMessages[section].first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            let dateString = dateFormatter.string(from: firstMessageInSection.date)

            let label = DateHeaderLabel()
            let calendar = Calendar.current

            if calendar.isDateInToday(firstMessageInSection.date) {
                label.text = "TODAY"
            } else if calendar.isDateInYesterday(firstMessageInSection.date) {
                label.text = "YESTERDAY"
            } else {
                label.text = dateString
            }

            return setupDateContainerView(label: label)
        }

        return nil

    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: messageCellId, for: indexPath) as! ChatMessageCell
        cell.selectionStyle = .none

        let chatMessage = chatMessages[indexPath.section][indexPath.row]
        cell.chatMessage = chatMessage


        return cell

    }

}

//MARK: - CardInformationViewDelegate

extension ChatVC: ChatTextFieldViewDelegate {

    func chatTextFieldViewButtonTapped(textMessage: String) {

        let currentDate = Date.getCurrentDate()
        let newMessage = [ChatMessageViewModel(image: nil, text: textMessage, isIncoming: false, date: Date.dateFromCustomString(customString: currentDate))]
        chatMessages.append(newMessage)

        
        tableView.reloadData()
        
    }

}


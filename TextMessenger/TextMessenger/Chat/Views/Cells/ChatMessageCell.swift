//
//  ChatMessangeCell.swift
//  TextMessenger
//
//  Created by Rishat on 03.10.2021.
//

import UIKit

// MARK: - Custom Cell

class ChatMessageCell: UITableViewCell {

    // MARK: - Private Properties

    private var profilePhotoImageView = UIImageView()

    private let dateTimeLabel = UILabel()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0

        return label
    }()

    private let bubbleBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12


        return view
    }()

    private var leadingConstraint: NSLayoutConstraint!
    private var trailingConstraint: NSLayoutConstraint!

    // MARK: - Public Properties

    var chatMessage: ChatMessageViewModel! {

        didSet {
            bubbleBackgroundView.backgroundColor = chatMessage.isIncoming ? .init(hexString: "#ECEBED") : .init(hexString: "#2E8AF6")
            messageLabel.textColor = chatMessage.isIncoming ? .init(hexString: "#181A1C") : .white
            dateTimeLabel.textColor = chatMessage.isIncoming ? .init(hexString: "#181A1C") : .init(hexString: "#727477")

            messageLabel.text = chatMessage.text
            messageLabel.font = UIFont.init(name: "Habibi-Regular", size: 14)

            dateTimeLabel.text = Date.getTimeInString(date: chatMessage.date)
            dateTimeLabel.font = UIFont.init(name: "Habibi-Regular", size: 12)

            if chatMessage.isIncoming {
                profilePhotoImageView.image = chatMessage.image
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
            } else {
                profilePhotoImageView.isHidden = true
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            }
        }

    }

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setupViews() {

        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        dateTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        profilePhotoImageView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(bubbleBackgroundView)
        self.addSubview(messageLabel)
        self.addSubview(dateTimeLabel)
        self.addSubview(profilePhotoImageView)

        setupConstraints()

        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: profilePhotoImageView.trailingAnchor, constant: 12)
        leadingConstraint.isActive = false

        trailingConstraint = self.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 28)
        trailingConstraint.isActive = true

    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([
            profilePhotoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            profilePhotoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 19),
            profilePhotoImageView.widthAnchor.constraint(equalToConstant: 24),
            profilePhotoImageView.heightAnchor.constraint(equalToConstant: 24),

            messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 28),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 268),

            messageLabel.topAnchor.constraint(equalTo: bubbleBackgroundView.topAnchor, constant: 4),
            messageLabel.leadingAnchor.constraint(equalTo: bubbleBackgroundView.leadingAnchor, constant: 8),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 4),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 8),

            dateTimeLabel.topAnchor.constraint(equalTo: bubbleBackgroundView.bottomAnchor, constant: 4),
            dateTimeLabel.trailingAnchor.constraint(equalTo: bubbleBackgroundView.trailingAnchor)
        ])

    }

}

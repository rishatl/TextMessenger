//
//  MessageTableViewCell.swift
//  TextMessenger
//
//  Created by Rishat on 09.10.2021.
//

import UIKit
import SnapKit

class ChatTableViewCell: UITableViewCell {

    // MARK: Display data structure

    struct ChatCellViewModel {

        let profileImage: UIImage?
        let username: String
        let lastMessage: String
        let date: String

    }


    // MARK: Private properties

    private let avatarImageView: UIImageView = {

        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true

        return imageView

    }()

    private let nameLabel: UILabel = {

        let label = UILabel()
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.init(name: "Habibi-Regular", size: 14)!)
        label.adjustsFontForContentSizeCategory = true

        return label

    }()

    private let lastMessageLabel: UILabel = {

        let label = UILabel()
        label.textColor = UIColor(hexString: "#727477")
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.init(name: "Habibi-Regular", size: 14)!)
        label.adjustsFontForContentSizeCategory = true

        return label

    }()

    private let dateLabel: UILabel = {

        let label = UILabel()
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.init(name: "Habibi-Regular", size: 12)!)
        label.adjustsFontForContentSizeCategory = true

        return label

    }()

    let label = UILabel()


    // MARL: Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
    }


    //MARK: Public

    func configure(chatModel: ChatCellViewModel) {

        if let image = chatModel.profileImage {
            avatarImageView.image = image
        } else {

            guard let firstCharacter = chatModel.username.first else { return }
            label.textColor = UIColor(hexString: "#2E8AF6")
            label.text = "\(firstCharacter)"
            avatarImageView.addSubview(label)
            avatarImageView.backgroundColor = UIColor(hexString: "#ECEBED")
            label.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
            }

        }

        nameLabel.text = chatModel.username
        lastMessageLabel.text = chatModel.lastMessage
        dateLabel.text = chatModel.date

    }

    // MARK: Private

    private func setupView() {

        self.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in

            make.centerY.equalTo(self.snp.centerY)
            make.width.height.equalTo(40)
            make.leading.equalTo(self.snp.leading).offset(24)
            
        }

        let stackView = UIStackView(arrangedSubviews: [nameLabel, lastMessageLabel])
        stackView.axis = .vertical
        stackView.spacing = 4

        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in

            make.centerY.equalToSuperview()
            make.leading.equalTo(avatarImageView.snp.trailing).offset(8)
            make.top.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-24)

        }

        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in

            make.top.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)

        }

    }
    
}

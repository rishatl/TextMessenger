//
//  Е.swift
//  TextMessenger
//
//  Created by Rishat on 04.10.2021.
//

import UIKit

//MARK: - Protocols

protocol ChatTextFieldViewDelegate: AnyObject {
    func chatTextFieldViewButtonTapped(textMessage: String)
}

//MARK: - Custom TextFieldView

class ChatTextFieldView: UIView {

    //MARK: - Private Properties

    private var chatMessage: ChatMessageViewModel!

    private let chatTextField: ChatTextField = {
        let textField = ChatTextField()
        textField.backgroundColor = .init(hexString: "#ECEBED")
        textField.font = UIFont.init(name: "Habibi-Regular", size: 14)
        textField.layer.cornerRadius = 20

        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font : UIFont(name: "Habibi-Regular", size: 14)!
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Type your message here...", attributes: attributes)

        return textField
    }()

    private let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "send"), for: .normal)
        button.addTarget(self, action: #selector(chatTextFieldViewButtonTapped), for: .touchUpInside)

        return button
    }()

    //MARK: - Delegate

    weak var delegate: ChatTextFieldViewDelegate?

    //MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private Methods

    private func setupViews() {

        setupChatTextField()
        setupSendButton()

    }

    private func setupChatTextField() {

        chatTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(chatTextField)

        NSLayoutConstraint.activate([
            chatTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            chatTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.bottomAnchor.constraint(equalTo: chatTextField.bottomAnchor, constant: 36),
            self.trailingAnchor.constraint(equalTo: chatTextField.trailingAnchor, constant: 16)
        ])

    }

    private func setupSendButton() {

        sendButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sendButton)

        NSLayoutConstraint.activate([
            sendButton.topAnchor.constraint(equalTo: chatTextField.topAnchor, constant: 4),
            chatTextField.trailingAnchor.constraint(equalTo: sendButton.trailingAnchor, constant: 4),
            sendButton.heightAnchor.constraint(equalToConstant: 32),
            sendButton.widthAnchor.constraint(equalToConstant: 32)
        ])

    }

    @objc private func chatTextFieldViewButtonTapped() {

        guard let textMessage = chatTextField.text else { return }
        delegate?.chatTextFieldViewButtonTapped(textMessage: textMessage)
        chatTextField.text = ""
    }

}

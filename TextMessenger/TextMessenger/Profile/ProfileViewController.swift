//
//  ProfileViewController.swift
//  TextMessenger
//
//  Created by Rishat on 09.10.2021.
//

import UIKit
import SnapKit

//MARK: - ViewModel

struct UserProfileViewModel {

    let username: String
    let city: String
    
}

//MARK: - ViewController

class ProfileViewController: UIViewController {

    //MARK: - Private Properties

    private let userData = UserProfileViewModel(username: "Alex Tsimikas", city: "Brooklyn, NY")

    private let cityLabel: UILabel = {

        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFontMetrics(forTextStyle: .body)
            .scaledFont(for: UIFont.init(name: "Habibi-Regular", size: 14)!)
        label.adjustsFontForContentSizeCategory = true

        return label

    }()

    private let logoutButton: UIButton = {

        let button = UIButton()

        button.backgroundColor = .clear
        button.layer.cornerRadius = 36 / 2
        button.layer.borderWidth = 1
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.adjustsImageSizeForAccessibilityContentSizeCategory = true
        button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)

        return button

    }()


    // MARK: Lifecycle

    override func viewDidLoad() {

        super.viewDidLoad()

        setupNavBar()
        setupView()

    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        if previousTraitCollection?.userInterfaceStyle == .dark {
            logoutButton.layer.borderColor = UIColor.black.cgColor
        } else {
            logoutButton.layer.borderColor = UIColor.white.cgColor
        }

    }

    // MARK: Private

    private func setupNavBar() {

        navigationItem.title = userData.username

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = .init(title: "Messages",
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(messagesTapped))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.init(name: "Habibi-Regular", size: 17)!)], for: .normal)
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.init(name: "Habibi-Regular", size: 17)!)], for: .highlighted)
        navigationItem.backButtonTitle = ""

    }

    private func setupView() {

        view.backgroundColor = .systemBackground
        cityLabel.text = userData.city
        view.addSubview(cityLabel)

        cityLabel.snp.makeConstraints { make in
            make.leadingMargin.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).inset(25)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(19)
        }

        setupLogoutButton()

    }

    private func setupLogoutButton() {

        let logoutContentView = createButtonContentViewWith(imageName: "arrow_left", buttonTitle: "Logout")
        logoutContentView.isUserInteractionEnabled = false
        logoutButton.addSubview(logoutContentView)
        view.addSubview(logoutButton)

        logoutButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
            make.top.equalTo(cityLabel.snp.bottom).offset(101)
        }

        logoutContentView.snp.makeConstraints { make in
          make.edges.equalToSuperview()
        }

    }

    private func createButtonContentViewWith(imageName: String, buttonTitle: String) -> UIView {

        let view = UIView()

        let buttonImageView = UIImageView()
        buttonImageView.image = UIImage(named: imageName)

        let buttonTitleLabel = UILabel()
        buttonTitleLabel.text = buttonTitle
        buttonTitleLabel.textAlignment = .left
        buttonTitleLabel.font = UIFontMetrics(forTextStyle: .body)
            .scaledFont(for: UIFont.init(name: "Habibi-Regular", size: 14)!)

        view.addSubview(buttonTitleLabel)
        view.addSubview(buttonImageView)
        
        buttonImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(34)
        }

        buttonTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(buttonImageView.snp.trailing).offset(19)
            make.trailing.equalToSuperview().offset(-32)
        }

        return view

    }

    @objc private func messagesTapped() {

        let vc = ChatsTableViewController()
        navigationController?.pushViewController(vc, animated: true)

    }

    @objc private func logoutTapped() {}

}

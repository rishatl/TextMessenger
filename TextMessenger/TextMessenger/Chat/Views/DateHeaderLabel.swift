//
//  DateHeaderLabel.swift
//  TextMessenger
//
//  Created by Rishat on 03.10.2021.
//

import UIKit

// MARK: - Custom Header Label

class DateHeaderLabel: UILabel {

    //MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        textColor = UIColor.init(hexString: "#727477")
        font = UIFont.init(name: "Habibi-Regular", size: 12)
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        let originalContentSize = super.intrinsicContentSize
        let height = originalContentSize.height + 12
        layer.cornerRadius = height / 2
        layer.masksToBounds = true

        return CGSize(width: originalContentSize.width + 20, height: height)
    }

}

//MARK: - Date Extension

extension Date {

    //MARK: - Static Methods

    static func dateFromCustomString(customString: String) -> Date {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"

        return dateFormatter.date(from: customString) ?? Date()

    }

    static func getTimeInString(date: Date) -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"

        return formatter.string(from: date)

    }

    static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"

        return dateFormatter.string(from: Date())

    }

}

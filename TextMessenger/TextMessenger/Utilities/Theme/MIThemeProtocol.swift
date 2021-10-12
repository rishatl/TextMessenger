//
//  MIThemeProtocol.swift
//  TextMessenger
//
//  Created by Rishat on 11.10.2021.
//

import UIKit

//MARK: - Protocol

public protocol MIThemeProtocol {

    var primaryBackGroundColor: UIColor? { get }
    var secondaryBackGroundColor: UIColor? { get }
    var placeholderBackGroundColor: UIColor? { get }

    var primaryTextColor: UIColor { get }
    var secondaryTextColor: UIColor { get }
    var placeholderTextColor: UIColor { get }

    var borderColor: UIColor { get }
    var selectionColor: UIColor { get }
    var interactiveColor: UIColor { get }
    var nonInteractiveColor: UIColor { get }

    var navBarTheme: MINavigationBarThemeProtocol { get }
    
}

//MARK: - Impinging Classes The MIThemeProtocol

public class MILightTheme: MIThemeProtocol {

    private init() { }

    internal static let shared = MILightTheme()

    public var primaryBackGroundColor: UIColor? { return .white}

    public var secondaryBackGroundColor: UIColor? { return UIColor(red: 0.95, green: 0.95, blue: 0.96, alpha: 1.00) }

    public var placeholderBackGroundColor: UIColor? { return UIColor(rbg: 245) }

    public var primaryTextColor: UIColor { return .black }

    public var secondaryTextColor: UIColor { return .darkGray }

    public var placeholderTextColor: UIColor { return .lightGray}

    public var borderColor: UIColor { return .lightGray }

    public var selectionColor: UIColor { return .lightGray }

    public var interactiveColor: UIColor { return .systemBlue }

    public var nonInteractiveColor: UIColor { return UIColor.systemBlue.withAlphaComponent(0.5) }

    public var navBarTheme: MINavigationBarThemeProtocol = MINavigationBarLightTheme.shared

}

public class MIDarkTheme: MIThemeProtocol {

    private init() { }

    internal static let shared = MIDarkTheme()

    public var primaryBackGroundColor: UIColor? { return UIColor(red: 7, green: 8, blue: 9) }

    public var secondaryBackGroundColor: UIColor? { return UIColor(red: 25, green: 26, blue: 27) }

    public var placeholderBackGroundColor: UIColor? { return UIColor(rbg: 14) }

    public var primaryTextColor: UIColor { return UIColor(red: 208, green: 208, blue: 208) }

    public var secondaryTextColor: UIColor { return UIColor(red: 90, green: 90, blue: 90) }

    public var placeholderTextColor: UIColor { return UIColor(rbg: 55) }

    public var borderColor: UIColor { return .darkGray }

    public var selectionColor: UIColor { return .lightGray }

    public var interactiveColor: UIColor { return .systemBlue }

    public var nonInteractiveColor: UIColor { return UIColor.systemBlue.withAlphaComponent(0.7) }

    public var navBarTheme: MINavigationBarThemeProtocol = MINavigationBarDarkTheme.shared

}


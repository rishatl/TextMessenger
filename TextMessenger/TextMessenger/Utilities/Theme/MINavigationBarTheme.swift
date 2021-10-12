//
//  MINavigationBarLightTheme.swift
//  TextMessenger
//
//  Created by Rishat on 11.10.2021.
//

import UIKit

//MARK: - Protocol

public protocol MINavigationBarThemeProtocol {

    var titleColor: UIColor  { get }
    var backgroundColor: UIColor? { get }
    var buttonColor: UIColor { get }

}

//MARK: - Public

class MINavigationBarLightTheme: MINavigationBarThemeProtocol {

    private init() { }

    internal static let shared = MINavigationBarLightTheme()

    public var titleColor: UIColor { return .black }

    public var backgroundColor: UIColor? { return .white }

    public var buttonColor: UIColor { return .black }

}

class MINavigationBarDarkTheme: MINavigationBarThemeProtocol {

    private init() { }

    internal static let shared = MINavigationBarDarkTheme()

    public var titleColor: UIColor { return .white }

    public var backgroundColor: UIColor? { return UIColor(hexString: "#1D1D1D") }

    public var buttonColor: UIColor { return UIColor(hexString: "#ECEBED") }
    
}

//MARK: - Extension

extension UINavigationController {

    public func setNavigationBarTheme(using theme: MINavigationBarThemeProtocol, and fontName: String = "") {
        
        let navBarAppearance = UINavigationBar.appearance()
        view.backgroundColor = MITheme.current.primaryBackGroundColor
        navBarAppearance.barTintColor = theme.backgroundColor
        navBarAppearance.tintColor = theme.buttonColor
        navBarAppearance.barTintColor = theme.backgroundColor
        navBarAppearance.shadowImage = UIImage()

    }
    
}


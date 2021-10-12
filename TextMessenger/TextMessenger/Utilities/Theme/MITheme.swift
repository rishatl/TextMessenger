//
//  MITheme.swift
//  TextMessenger
//
//  Created by Rishat on 11.10.2021.
//

import UIKit

//MARK: - Protocol

protocol Themable {

    func setColors()

}

//MARK: - Public

enum MIUserInterfaceStyle {

    case dark
    case light

    @available(iOS 13.0, *)
    case system
    
}

class MITheme {

    fileprivate static var light: MIThemeProtocol = MILightTheme.shared
    fileprivate static var dark: MIThemeProtocol = MIDarkTheme.shared

    static var style: MIUserInterfaceStyle = _style
    static var current: MIThemeProtocol = light


    private static var _style: MIUserInterfaceStyle {

        get {
            if #available(iOS 13.0, *) {
                return .system
            }

            return .light
        }

    }

}

//MARK: - Extensions

extension MITheme {

    static func setDarkTheme() {
        current = dark
    }

    static func setLightTheme() {
        current = light
    }

    static func setStyle(_ style: MIUserInterfaceStyle) {

        MITheme.style = style
        switch style {
        case .dark:
            current = dark
        case .light:
            current = light
        case .system:
            print("Theme will be updated when view loads the next time")
        }

    }

}

extension MITheme {

    @available(iOS 13.0, *)
    static func update(basedOn userInterfaceStyle: UIUserInterfaceStyle) {

        guard MITheme.style == .system else { return }

        switch userInterfaceStyle {
        case .dark:
            current = dark
        case .light, .unspecified:
            current = light
        @unknown default:
            assertionFailure("Support not provided for new theme yet.")
        }

    }

}


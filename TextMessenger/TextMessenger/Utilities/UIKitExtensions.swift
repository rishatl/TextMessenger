//
//  UIKitExtensions.swift
//  TextMessenger
//
//  Created by Rishat on 11.10.2021.
//

import UIKit

//MARK: - Custom View

@available(iOS 13, *)
private class DPStatusBarView: UIView {

    init(backgroundColor: UIColor?) {

        super.init(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
        self.backgroundColor = backgroundColor

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - Extensions

extension UIApplication {

    //MARK: - Public

    // Call this method from baseController's viewWillTransistion
    // to avoid UI glitches in the status bar area when user changes orientation
    @available(iOS 13.0, *)
    func removeStatusBarView() {

        if let statusBar = keyWindow?.subviews.compactMap({ $0 as? DPStatusBarView }).first {
            statusBar.removeFromSuperview()
        }

    }

    func setStatusBarColor(_ color: UIColor?) {

        if #available(iOS 13.0, *) {
            addStatusBarView(withBG: color)
        } else {
            statusBarView?.backgroundColor = color
        }

    }

    //MARK: - Private

    @available(iOS, introduced: 9.0, deprecated: 13.0)
    private var statusBarView: UIView? {

        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }

        return nil

    }

    @available(iOS 13.0, *)
    private func addStatusBarView(withBG color: UIColor?) {

        guard let statusBar = keyWindow?.subviews.compactMap({ $0 as? DPStatusBarView }).first else {

            let statusBar = DPStatusBarView(backgroundColor: color)
            keyWindow?.addSubview(statusBar)

            return

        }

        statusBar.backgroundColor = color

    }

}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1)
    }

    convenience init(rbg: Int) {
        self.init(red: CGFloat(rbg)/255, green: CGFloat(rbg)/255, blue: CGFloat(rbg)/255, alpha: 1)
    }
}

extension UITableView: Themable {

    func setColors() {

        guard let indices = indexPathsForVisibleRows else { return }

        for indexPath in indices {

            if let cell = cellForRow(at: indexPath) as? Themable {
                cell.setColors()
            } else {
                assertionFailure("Confirm \(self) to Themable")
            }

        }

    }

}

extension UINavigationController {

    public func setColors(using theme: MINavigationBarThemeProtocol) {

        view.backgroundColor = MITheme.current.primaryBackGroundColor
        navigationBar.barTintColor = theme.backgroundColor
        navigationBar.tintColor = theme.buttonColor
        UIApplication.shared.setStatusBarColor(theme.backgroundColor)

    }

}


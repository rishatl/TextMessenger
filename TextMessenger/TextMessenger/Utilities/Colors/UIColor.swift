//
//  UIColor.swift
//  TextMessenger
//
//  Created by Rishat on 03.10.2021.
//

import Foundation
import UIKit

extension UIColor {

    // detecting color is light or not
    var isLightColor: Bool {

        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  lum > 0.70 ? true : false

    }

    var hex: String {

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let rgb: Int = (Int)(red * 255) << 16 | (Int)(green * 255) << 8 | (Int)(blue * 255) << 0

        return String(format:"#%06x", rgb)

    }

    convenience init(hex: Int, alpha: Double = 1.0) {

        self.init(red: CGFloat((hex>>16)&0xFF)/255.0,
                  green: CGFloat((hex>>8)&0xFF)/255.0,
                  blue: CGFloat((hex)&0xFF)/255.0,
                  alpha: CGFloat(255 * alpha) / 255)

    }

    convenience init(hexString: String, alpha: Double = 1.0) {

        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(255 * alpha) / 255)

    }

    static func random(seed: String) -> UIColor {

        var total: Int = 0
        for u in seed.unicodeScalars {
            total += Int(UInt32(u))
        }
        srand48(total * 200)
        let r = CGFloat(drand48())
        srand48(total)
        let g = CGFloat(drand48())
        srand48(total / 200)
        let b = CGFloat(drand48())
        return UIColor(red: r, green: g, blue: b, alpha: 1)

    }

}

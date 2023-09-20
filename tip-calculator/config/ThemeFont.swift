//
//  ThemeFont.swift
//  tip-calculator
//
//  Created by Arystan on 11.09.2023.
//

import UIKit

struct ThemeFont {
    // AvenirNext
    static func regular(ofsize size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func bold(ofsize size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func demibold(ofsize size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-DemiBold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
}

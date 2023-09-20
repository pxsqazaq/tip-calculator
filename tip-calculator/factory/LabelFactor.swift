//
//  LabelFactor.swift
//  tip-calculator
//
//  Created by Arystan on 11.09.2023.
//

import UIKit

struct LabelFactor {
    static func build(
        text: String?,
        font: UIFont,
        backgroundColor: UIColor = .clear,
        textColor: UIColor = ThemeColor.text,
        textAlignment: NSTextAlignment = .center) -> UILabel {
            let label = UILabel()
            label.text = text
            label.font = font
            label.textColor = textColor
            label.textAlignment = textAlignment
            label.backgroundColor = backgroundColor
            return label
        }
    
}

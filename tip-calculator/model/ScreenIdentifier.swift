//
//  ScreenIdentifier.swift
//  tip-calculator
//
//  Created by Arystan on 19.09.2023.
//

import Foundation

enum ScreenIdentifier {
    
    enum LogoView: String {
        case logoView
    }
    
    enum ResultView: String {
        case totalAmountPerPersonValueLabel
        case totalBillValueLabel
        case totalTipValueLabel
    }
    
    enum BillInputView: String {
        case textField
    }
    
    enum TipInputView: String {
        case tenPercentButton
        case fifteenPercentButton
        case twentyPercentButton
        case customTipButton
    }
    
    enum SplitInputView: String {
        case decrementButton
        case incrementButton
        case quantityValueLabel
    }
}

//
//  AmountView.swift
//  tip-calculator
//
//  Created by Arystan on 12.09.2023.
//

import UIKit
import SnapKit

class AmountView: UIView {
    
    private let title: String
    private let textAligmnet: NSTextAlignment
    private let amountLabelIdentifier: String
    
    private lazy var titleLabel: UILabel = {
        return LabelFactor.build(
            text: title,
            font: ThemeFont.regular(ofsize: 18),
            textColor: ThemeColor.text,
            textAlignment: textAligmnet
        )
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = textAligmnet
        let text = NSMutableAttributedString(
            string: "$0",
            attributes: [
                .font: ThemeFont.bold(ofsize: 24),
            ])
        text.addAttributes([.font: ThemeFont.bold(ofsize: 16)], range: NSRange(location: 0, length: 1))
        label.attributedText = text
        label.textColor = ThemeColor.primary
        label.accessibilityIdentifier = amountLabelIdentifier
        
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            titleLabel,
            amountLabel
        ])
        view.axis = .vertical
        return view
    }()
    
    init(title: String, textAlignment: NSTextAlignment, amountLabelIdentifier: String) {
        self.title = title
        self.textAligmnet = textAlignment
        self.amountLabelIdentifier = amountLabelIdentifier
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(amount: Double) {
        let text = NSMutableAttributedString(
            string: "$"+amount.currencyFormatted,
            attributes: [.font: ThemeFont.bold(ofsize: 24)])
        text.addAttributes(
            [.font: ThemeFont.bold(ofsize: 16)],
            range: NSMakeRange(0, 1))
        amountLabel.attributedText = text
    }
    
    private func layout() {
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

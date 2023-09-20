//
//  HeaderView.swift
//  tip-calculator
//
//  Created by Arystan on 13.09.2023.
//

import Foundation
import UIKit

class HeaderView: UIView {
    
    private let topLabel: UILabel = {
        LabelFactor.build(text: nil, font: ThemeFont.bold(ofsize: 18))
    }()
    
    private let bottomLabel: UILabel = {
        LabelFactor.build(text: nil, font: ThemeFont.regular(ofsize: 16))
    }()
    
    private let topSpacerView = UIView()
    private let bottomSpacerView = UIView()
    
    private lazy var stackView: UIStackView = {
       let view = UIStackView(arrangedSubviews: [
            topSpacerView,
            topLabel,
            bottomLabel,
            bottomSpacerView
       ])
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = -4
        return view
    }()

    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        topSpacerView.snp.makeConstraints { make in
            make.height.equalTo(bottomSpacerView)
        }
    }
    
    func configure(topText: String, bottomText: String) {
        topLabel.text = topText
        bottomLabel.text = bottomText
    }
}

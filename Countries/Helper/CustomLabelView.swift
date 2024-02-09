//
//  CustomLabelView.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 9.02.2024.
//

import Foundation

import UIKit
import SnapKit

class CustomLabelView: SpringView {
    
    var iconImage: String = "" {
        didSet {
            iconImageView.image = UIImage(named: iconImage)
        }
    }
    
    var titleText: String = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var contentText: String = "" {
        didSet {
            contentLabel.text = contentText
        }
    }
    
    private lazy var stackView: SpringStackView = {
        let sv = SpringStackView()
        sv.axis = .horizontal
        sv.spacing = 10
        sv.distribution = .fill
//        sv.contentMode = .center
//        sv.alignment = .center
        return sv
    }()
    
    private lazy var iconImageView: SpringImageView = {
        let imageView = SpringImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: SpringLabel = {
        let label = SpringLabel()
        label.font = UIFont(name: AppFont.bold, size: FontSize.small.fontSize)
        label.textColor = AppColor.blackTint.color
        return label
    }()

    lazy var contentLabel: SpringLabel = {
        let label = SpringLabel()
        label.font = UIFont(name: AppFont.bold, size: FontSize.small.fontSize)
        label.numberOfLines = 0
        label.textColor = AppColor.blackTint.color
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
      
        setupViews()
    }
    
    override func layoutSubviews() {
        self.addShadow()
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        self.addSubviews(stackView,
                         contentLabel)
        stackView.addArrangedSubviews(iconImageView,
                                      titleLabel)
        setupLayouts()
    }
    
    private func setupLayouts() {
        
        iconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(20)
        }

        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.centerY.equalTo(iconImageView.snp.centerY)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
//            make.centerX.equalTo(stackView.snp.centerX)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

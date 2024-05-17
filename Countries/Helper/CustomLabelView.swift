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
    
    private lazy var titleStackView: SpringStackView = {
        let sv = SpringStackView()
        sv.axis = .horizontal
        sv.spacing = 10
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
        label.contentMode = .center
        return label
    }()

    lazy var contentLabel: SpringLabel = {
        let label = SpringLabel()
        label.font = UIFont(name: AppFont.regular, size: FontSize.small.fontSize)
        label.numberOfLines = 0
        label.textColor = AppColor.blackTint.color
        return label
    }()
    
    private lazy var secondStackView: SpringStackView = {
        let sv = SpringStackView()
        sv.axis = .vertical
        sv.spacing = 5
        sv.alignment = .center
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
      
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.addCornerRadius(corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner,
                                       .layerMinXMaxYCorner, .layerMinXMinYCorner],
                             radius: 16)
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        self.addSubviews(secondStackView)
        titleStackView.addArrangedSubviews(iconImageView, titleLabel)
        secondStackView.addArrangedSubviews(titleStackView, contentLabel)
        setupLayouts()
    }
    
    private func setupLayouts() {
        iconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(20)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView.snp.centerY)
        }
        
        titleStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        secondStackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
            make.bottom.trailing.equalToSuperview().offset(-8)
        }
    }
    
}

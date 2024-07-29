//
//  CustomLabelView.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 9.02.2024.
//

import UIKit
import SnapKit

class CustomLabelView: SpringView {
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
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = AppColor.title.color
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = AppColor.title.color
        return label
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.textColor = AppColor.subtitle.color
        label.textAlignment = .left
        return label
    }()
    private lazy var labelsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 4
        sv.alignment = .leading
        return sv
    }()
    
    // MARK: LifeCycle
    
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
        iconImageView.addCornerRadius(corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner,
                                       .layerMinXMaxYCorner, .layerMinXMinYCorner],
                             radius: 8)
        self.addShadow()
    }
    
    // MARK: View Layout & Setup Functions
    
    private func setupViews() {
                
        setupSubviews()
        setupLayouts()
    }
    
    private func setupLayouts() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalTo(self.snp.centerY)
            make.width.height.equalTo(30)
        }
        labelsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    private func setupSubviews() {
        self.backgroundColor = AppColor.contentBackground.color
        labelsStackView.addArrangedSubviews(titleLabel, contentLabel)
        self.addSubviews(iconImageView, labelsStackView)
    }
}

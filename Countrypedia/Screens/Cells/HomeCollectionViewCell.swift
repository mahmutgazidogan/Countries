//
//  HomeCollectionViewCell.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 8.11.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class HomeCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeCell"
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    private lazy var nameView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.layer.masksToBounds = true
    }
    
    public func configure(model: Country) {
        imageView.kf.setImage(with: URL(string: model.flags?.png ?? AppConstants.emptyString.text))
        nameLabel.text = model.name?.common
    }
    private func setupViews() {
        contentView.backgroundColor = AppColor.contentBackground.color
        contentView.addSubviews(imageView,
                                nameLabel)
        setupLayouts()
    }
    private func setupLayouts() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.snp.height).multipliedBy(0.75)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(contentView.snp.height).multipliedBy(0.25)
        }
    }
}

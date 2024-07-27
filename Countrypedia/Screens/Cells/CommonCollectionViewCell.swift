//
//  HomeCollectionViewCell.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 8.11.2023.
//

import UIKit
import SnapKit
import Kingfisher

protocol CommonCellDelegate: AnyObject {
    func didTapFavoriteButton(on cell: CommonCollectionViewCell)
}

final class CommonCollectionViewCell: UICollectionViewCell {
    static let identifier = "CommonCell"
    weak var delegate: CommonCellDelegate?
    private let countryView = UIView()
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = AppColor.title.color
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        contentView.clipsToBounds = false // kalp butonuyla birlikte eklendi
        
        countryView.layer.cornerRadius = 20
        countryView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        countryView.layer.masksToBounds = true
        countryView.addShadow()
        
        imageView.layer.cornerRadius = 20
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.layer.masksToBounds = true
        favoriteButton.layer.borderWidth = 0.2
        favoriteButton.layer.borderColor = AppColor.border.color.cgColor
        favoriteButton.layer.cornerRadius = 10
        favoriteButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        favoriteButton.layer.masksToBounds = true
        favoriteButton.addShadow()
    }
    
    public func configure(model: Country) {
        imageView.kf.setImage(with: URL(string: model.flags?.png ?? AppConstants.emptyString.text))
        nameLabel.text = model.name?.common
        favoriteButton.isSelected = model.isFavorited 
    }
    private func setupViews() {
        contentView.backgroundColor = AppColor.mainBackground.color
        countryView.backgroundColor = AppColor.contentBackground.color
        countryView.addSubviews(imageView, nameLabel)
        contentView.addSubviews(countryView, favoriteButton)
//        let gradient = UIColor.applyGradient(colors: [#colorLiteral(red: 0.9921568627, green: 0.7254901961, blue: 0.07058823529, alpha: 1), #colorLiteral(red: 0.662745098, green: 0.01568627451, blue: 0.1960784314, alpha: 1)], bounds: CGRect(x: 0, y: 0, width: 30, height: 30))
        favoriteButton.backgroundColor = AppColor.contentBackground.color
        setupLayouts()
        setupFavoriteButton()
    }
    private func setupLayouts() {
        countryView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.leading.bottom.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
//            make.height.equalTo(contentView.snp.height).multipliedBy(0.75)
            make.height.equalToSuperview().multipliedBy(0.75)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
//            make.height.equalTo(contentView.snp.height).multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(0.25)
        }
        favoriteButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.top.equalTo(contentView.snp.top)
            make.trailing.equalTo(contentView.snp.trailing)
        }
    }
    private func setupFavoriteButton() {
        let action = UIAction { [weak self] _ in
            self?.buttonTapped()
        }
        favoriteButton.addAction(action, for: .primaryActionTriggered)
    }
    
    func buttonTapped() {
        delegate?.didTapFavoriteButton(on: self)
    }
    
}

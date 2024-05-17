//
//  DetailsViewController.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 19.01.2024.
//

import UIKit
import SnapKit
import Kingfisher
import MapKit

class DetailsViewController: UIViewController {
    
    var presenter: DetailsViewToPresenterProtocol?
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.mapType = .hybridFlyover
        mapView.delegate = self
        return mapView
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let ind = UIActivityIndicatorView()
        ind.color = AppColor.blackTint.color
        ind.style = .large
        return ind
    }()
    
    private lazy var mapIndicator: UIActivityIndicatorView = {
        let ind = UIActivityIndicatorView()
        ind.color = AppColor.blackTint.color
        ind.style = .large
        return ind
    }()
    
    private lazy var scrollView: SpringScrollView = {
        let scrollView = SpringScrollView()
        scrollView.backgroundColor = AppColor.clearBackground.color
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private lazy var contentView: DesignableView = {
        let view = DesignableView()
        view.backgroundColor = .cyan
        view.animation = "slideUp"
        view.duration = 2
        view.damping = 1
        view.animate()
        return view
    }()
    
    private lazy var nameView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Country"
        view.iconImage = "country"
        view.contentLabel.textAlignment = .center
        return view
    }()
    
    private lazy var capitalView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Capital"
        view.iconImage = "capital"
        view.contentLabel.textAlignment = .center
        return view
    }()
    
    private lazy var independencyView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Independency"
        view.iconImage = "independence"
        view.contentLabel.textAlignment = .center
        return view
    }()
    
    private lazy var areaView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Area"
        view.iconImage = "area"
        view.contentLabel.textAlignment = .center
        return view
    }()
    
    private lazy var populationView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Population"
        view.iconImage = "population"
        view.contentLabel.textAlignment = .center
        return view
    }()
    
    private lazy var startOfWeekView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Start of Week"
        view.iconImage = "startOfWeek"
        view.contentLabel.textAlignment = .center
        return view
    }()
    
    private lazy var currencyView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Currencies"
        view.iconImage = "currency"
        view.contentLabel.textAlignment = .center
        return view
    }()
    
    private lazy var countryCodeView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Country Code"
        view.iconImage = "code"
        view.contentLabel.textAlignment = .center
        return view
    }()
    
    private lazy var timezoneView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Timezones"
        view.iconImage = "timezone"
        view.contentLabel.textAlignment = .center
        return view
    }()
    
    private lazy var languageView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Languages"
        view.iconImage = "languages"
        view.contentLabel.textAlignment = .center
        return view
    }()
    
    private lazy var plateCodeView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Plate Code"
        view.iconImage = "carSign"
        view.contentLabel.textAlignment = .center
        return view
    }()
    
    private lazy var trafficDirectionView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Traffic Direction"
        view.iconImage = "leftRight"
        view.contentLabel.textAlignment = .center
        return view
    }()
    
    private lazy var flagDescriptionView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Flag Description"
        view.iconImage = "flag"
        view.contentLabel.textAlignment = .left
        view.contentLabel.font = UIFont(name: AppFont.regular, size: FontSize.small.fontSize)
        return view
    }()
    
    private lazy var flagImageView: SpringImageView = {
        let iv = SpringImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.backgroundColor = nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layoutSubviews()
    }
    
    private func layoutSubviews() {
        scrollView.addCornerRadius(corners: [.layerMaxXMinYCorner,
                                             .layerMinXMinYCorner],
                                   radius: 80)
        let height = countryCodeView.frame.height + countryCodeView.frame.origin.y
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: height)
        contentView.addCornerRadius(corners: [.layerMaxXMinYCorner,
                                              .layerMinXMinYCorner],
                                    radius: 80)
        
        flagImageView.addCornerRadius(corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner,
                                                .layerMaxXMinYCorner, .layerMaxXMaxYCorner],
                                      radius: 16)
        flagImageView.layer.borderWidth = 0.4
        flagImageView.layer.borderColor = AppColor.grayBorder.color.cgColor
    }
    
    private func updateUI() {
        presenter?.updateUI()
    }
    
    private func showCountryOnMap(latitude: Double, longitude: Double, title: String) {
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        let span = MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        annotation.coordinate = coordinates
        annotation.subtitle = title
        annotation.title = AppConstants.capital.text
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
    }
    
    private func showLoadingIndicator() {
        indicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        indicator.stopAnimating()
    }
    
    private func setupViews() {
        navigationController?.navigationBar.tintColor = AppColor.blackTint.color
        navigationController?.navigationBar.backgroundColor = AppColor.lightTextBackground.color
        view.backgroundColor = AppColor.whiteBackground.color
        view.addSubviews(mapView, scrollView)
        mapView.addSubview(mapIndicator)
        scrollView.addSubview(contentView)
        contentView.addSubviews(indicator, nameView, capitalView, independencyView,
                                areaView, populationView, startOfWeekView,
                                currencyView, timezoneView, languageView,
                                plateCodeView, trafficDirectionView,
                                countryCodeView, flagImageView, flagDescriptionView)
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        mapIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        indicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }

        
        nameView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.75)
        }
        
        capitalView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.75)
        }
        
        independencyView.snp.makeConstraints { make in
            make.top.equalTo(capitalView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(8)
            make.width.equalToSuperview().multipliedBy(0.45)
        }
        
        areaView.snp.makeConstraints { make in
            make.top.equalTo(capitalView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-8)
            make.width.equalToSuperview().multipliedBy(0.45)
        }
        
        populationView.snp.makeConstraints { make in
            make.top.equalTo(areaView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(8)
            make.width.equalToSuperview().multipliedBy(0.45)
        }
        
        startOfWeekView.snp.makeConstraints { make in
            make.top.equalTo(areaView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-8)
            make.width.equalToSuperview().multipliedBy(0.45)
        }
        
        currencyView.snp.makeConstraints { make in
            make.top.equalTo(startOfWeekView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(8)
            make.width.equalToSuperview().multipliedBy(0.45)
        }
        
        languageView.snp.makeConstraints { make in
            make.top.equalTo(startOfWeekView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-8)
            make.width.equalToSuperview().multipliedBy(0.45)
        }
        
        plateCodeView.snp.makeConstraints { make in
            make.top.equalTo(currencyView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(8)
            make.width.equalToSuperview().multipliedBy(0.45)
        }
        
        trafficDirectionView.snp.makeConstraints { make in
            make.top.equalTo(languageView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-8)
            make.width.equalToSuperview().multipliedBy(0.45)
        }
        
        timezoneView.snp.makeConstraints { make in
            make.top.equalTo(plateCodeView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        flagImageView.snp.makeConstraints { make in
            make.top.equalTo(timezoneView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(8)
            make.width.equalToSuperview().multipliedBy(0.45)
            make.height.equalToSuperview().multipliedBy(0.05)
            make.center.equalTo(flagDescriptionView.snp.center)
        }
        
        flagDescriptionView.snp.makeConstraints { make in
            make.top.equalTo(timezoneView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-8)
            make.width.equalToSuperview().multipliedBy(0.45)
        }
        
        countryCodeView.snp.makeConstraints { make in
            make.top.equalTo(flagDescriptionView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
    }
    
}

extension DetailsViewController: UIScrollViewDelegate {}

extension DetailsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "customAnnotation"
        var annotationView: MKAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            dequeuedView.annotation = annotation
            annotationView = dequeuedView
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "location")
        }
        return annotationView
    }
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        mapIndicator.startAnimating()
    }
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        mapIndicator.stopAnimating()
    }
}

extension DetailsViewController: DetailsPresenterToViewProtocol {
    func showDetails(name: String, capital: String, area: String,
                     population: String, startOfWeek: String,
                     currency: String, timezones: String,
                     flag: String, flagDescription: String,
                     languages: String, sign: String, side: String,
                     independency: String, latitude: Double, longitude: Double) {
        DispatchQueue.main.async { [weak self] in
            self?.nameView.contentText = name
            self?.capitalView.contentText = capital
            self?.independencyView.contentText = independency
            self?.areaView.contentText = "\(area) km²"
            self?.populationView.contentText = population
            self?.startOfWeekView.contentText = startOfWeek
            self?.currencyView.contentText = currency
            self?.timezoneView.contentText = timezones
            self?.plateCodeView.contentText = sign
            self?.trafficDirectionView.contentText = side
            self?.flagImageView.kf.setImage(with: URL(string: flag))
            self?.flagDescriptionView.contentText = flagDescription
            self?.languageView.contentText = languages
            self?.showCountryOnMap(latitude: latitude, longitude: longitude, title: capital)
        }
    }
}



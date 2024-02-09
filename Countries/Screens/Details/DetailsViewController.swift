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
    
    private lazy var detailsView: DesignableView = {
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
    
    private lazy var timezoneView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Timezones"
        view.iconImage = "timezone"
        view.contentLabel.textAlignment = .left
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
        return view
    }()
    
    private lazy var flagImageView: SpringImageView = {
        let iv = SpringImageView()
        iv.contentMode = .scaleToFill
        iv.animation = "slideUp"
        iv.duration = 2
        iv.animate()
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
        detailsView.layer.cornerRadius = 80
        detailsView.layer.maskedCorners = [.layerMaxXMinYCorner,
                                           .layerMinXMinYCorner]
        detailsView.layer.masksToBounds = true
        
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
        view.addSubviews(mapView, detailsView)
        mapView.addSubview(mapIndicator)
        detailsView.addSubviews(indicator, nameView, capitalView, independencyView,
                                areaView, populationView, startOfWeekView,
                                currencyView, timezoneView, languageView,
                                plateCodeView, trafficDirectionView, flagImageView,
                                flagDescriptionView)
        
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
        
        detailsView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        indicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }

        
        nameView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
        
        capitalView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
        
        independencyView.snp.makeConstraints { make in
            make.top.equalTo(capitalView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        areaView.snp.makeConstraints { make in
            make.top.equalTo(independencyView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        populationView.snp.makeConstraints { make in
            make.top.equalTo(areaView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        startOfWeekView.snp.makeConstraints { make in
            make.top.equalTo(populationView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        currencyView.snp.makeConstraints { make in
            make.top.equalTo(startOfWeekView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        timezoneView.snp.makeConstraints { make in
            make.top.equalTo(currencyView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        languageView.snp.makeConstraints { make in
            make.top.equalTo(timezoneView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        plateCodeView.snp.makeConstraints { make in
            make.top.equalTo(languageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        trafficDirectionView.snp.makeConstraints { make in
            make.top.equalTo(plateCodeView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        flagImageView.snp.makeConstraints { make in
            make.top.equalTo(trafficDirectionView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(90)
            make.width.equalTo(150)
        }
        
        flagDescriptionView.snp.makeConstraints { make in
            make.top.equalTo(flagImageView.snp.top)
            make.leading.equalTo(flagImageView.snp.trailing)
            make.trailing.equalToSuperview()
        }
        
    }
    
}

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



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
    
    private lazy var nameLabel: SpringLabel = {
        let label = SpringLabel()
        label.font = UIFont(name: "Arial-Bold", size: 30)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.animation = "slideUp"
        label.duration = 2
        label.animate()
        return label
    }()
    
    private lazy var independencyLabel: SpringLabel = {
        let label = SpringLabel()
        label.font = UIFont(name: "Arial-Bold", size: 30)
        label.textAlignment = .center
        label.text = "Independent:"
        label.animation = "slideUp"
        label.duration = 2
        label.animate()
        return label
    }()
    
    private lazy var capitalLabel: SpringLabel = {
        let label = SpringLabel()
        label.font = UIFont(name: "Arial-Bold", size: 30)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.animation = "slideUp"
        label.duration = 2
        label.animate()
        return label
    }()
    
    private lazy var checkboxImageView: SpringImageView = {
        let iv = SpringImageView()
        iv.contentMode = .scaleToFill
        iv.animation = "slideUp"
        iv.duration = 2
        iv.animate()
        return iv
    }()
    
    private lazy var areaLabel: SpringLabel = {
        let label = SpringLabel()
        label.font = UIFont(name: "Arial-Bold", size: 30)
        label.textAlignment = .center
        label.animation = "slideUp"
        label.duration = 2
        label.animate()
        return label
    }()
    
    private lazy var populationLabel: SpringLabel = {
        let label = SpringLabel()
        label.font = UIFont(name: "Arial-Bold", size: 30)
        label.textAlignment = .center
        label.animation = "slideUp"
        label.duration = 2
        label.animate()
        return label
    }()
    
    private lazy var startOfWeekLabel: SpringLabel = {
        let label = SpringLabel()
        label.font = UIFont(name: "Arial-Bold", size: 30)
        label.textAlignment = .center
        label.animation = "slideUp"
        label.duration = 2
        label.animate()
        return label
    }()
    
    private lazy var currencyLabel: SpringLabel = {
        let label = SpringLabel()
        label.font = UIFont(name: "Arial-Bold", size: 30)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1.0
        label.backgroundColor = .systemYellow
        label.animation = "slideUp"
        label.duration = 2
        label.animate()
        return label
    }()
    
    private lazy var timezonesLabel: SpringLabel = {
        let label = SpringLabel()
        label.font = UIFont(name: "Arial-Bold", size: 30)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.animation = "slideUp"
        label.duration = 2
        label.animate()
        return label
    }()
    
    private lazy var languagesLabel: SpringLabel = {
        let label = SpringLabel()
        label.font = UIFont(name: "Arial-Bold", size: 30)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.animation = "slideUp"
        label.duration = 2
        label.animate()
        return label
    }()
    
    private lazy var carDatasLabel: SpringLabel = {
        let label = SpringLabel()
        label.font = UIFont(name: "Arial-Bold", size: 30)
        label.numberOfLines = 0
        label.animation = "slideUp"
        label.duration = 2
        label.animate()
        return label
    }()
    
    private lazy var flagImageView: SpringImageView = {
        let iv = SpringImageView()
        iv.contentMode = .scaleToFill
        iv.animation = "slideUp"
        iv.duration = 2
        iv.animate()
        return iv
    }()
    
    private lazy var flagDescriptionLabel: SpringLabel = {
        let label = SpringLabel()
        label.font = UIFont(name: "Arial", size: 10)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.animation = "slideUp"
        label.duration = 2
        label.animate()
        return label
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
        checkboxImageView.layer.cornerRadius = 5
        checkboxImageView.layer.maskedCorners = [.layerMaxXMaxYCorner,
                                                 .layerMaxXMinYCorner,
                                                 .layerMinXMaxYCorner,
                                                 .layerMinXMinYCorner]
        checkboxImageView.layer.masksToBounds = true
        
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
        view.addSubviews(mapView, indicator, nameLabel, capitalLabel, independencyLabel,
                         checkboxImageView, areaLabel, populationLabel, startOfWeekLabel,
                         currencyLabel, timezonesLabel, languagesLabel, carDatasLabel,
                         flagImageView, flagDescriptionLabel)
        mapView.addSubview(mapIndicator)
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        mapIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        indicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
        
        capitalLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        independencyLabel.snp.makeConstraints { make in
            make.top.equalTo(capitalLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        
        checkboxImageView.snp.makeConstraints { make in
            make.leading.equalTo(independencyLabel.snp.trailing).offset(5)
            make.width.height.equalTo(15)
            make.centerY.equalTo(independencyLabel.snp.centerY)
        }
        
        areaLabel.snp.makeConstraints { make in
            make.top.equalTo(independencyLabel.snp.bottom)
            make.leading.equalTo(independencyLabel.snp.leading)
            make.height.equalTo(20)
        }
        
        populationLabel.snp.makeConstraints { make in
            make.top.equalTo(areaLabel.snp.bottom)
            make.leading.equalTo(areaLabel.snp.leading)
            make.height.equalTo(20)
        }
        
        startOfWeekLabel.snp.makeConstraints { make in
            make.top.equalTo(populationLabel.snp.bottom)
            make.leading.equalTo(populationLabel.snp.leading)
            make.height.equalTo(20)
        }
        
        currencyLabel.snp.makeConstraints { make in
            make.top.equalTo(startOfWeekLabel.snp.bottom)
            make.leading.equalTo(startOfWeekLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        timezonesLabel.snp.makeConstraints { make in
            make.top.equalTo(currencyLabel.snp.bottom)
            make.leading.equalTo(currencyLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        languagesLabel.snp.makeConstraints { make in
            make.top.equalTo(timezonesLabel.snp.bottom)
            make.leading.equalTo(timezonesLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        carDatasLabel.snp.makeConstraints { make in
            make.top.equalTo(languagesLabel.snp.bottom)
            make.leading.equalTo(languagesLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        flagImageView.snp.makeConstraints { make in
            make.top.equalTo(carDatasLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(90)
            make.width.equalTo(150)
        }
        
        flagDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(flagImageView.snp.bottom).offset(20)
            make.leading.equalTo(carDatasLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-20)
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
                     languages: String, carDetails: String,
                     independency: UIImage?, latitude: Double, longitude: Double) {
        DispatchQueue.main.async { [weak self] in
            self?.nameLabel.text = name
            self?.capitalLabel.text = capital
            self?.checkboxImageView.image = independency
            self?.areaLabel.text = "Area: \(area) km²"
            self?.populationLabel.text = "Population: \(population)"
            self?.startOfWeekLabel.text = "Start of Week: \(startOfWeek)"
            self?.currencyLabel.text = "Currency: \(currency)"
            self?.timezonesLabel.text = "Timezones: \(timezones)"
            self?.carDatasLabel.text = carDetails
            self?.flagImageView.kf.setImage(with: URL(string: flag))
            self?.flagDescriptionLabel.text = flagDescription
            self?.languagesLabel.text = languages
            self?.showCountryOnMap(latitude: latitude, longitude: longitude, title: capital)
        }
    }
}



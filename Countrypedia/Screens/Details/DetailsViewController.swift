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

final class DetailsViewController: UIViewController {
    var presenter: DetailsViewToPresenterProtocol?
    private lazy var scrollView: SpringScrollView = {
        let scrollView = SpringScrollView()
        scrollView.backgroundColor = AppColor.mainBackground.color
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    private lazy var contentView: DesignableView = {
        let view = DesignableView()
        view.backgroundColor = AppColor.mainBackground.color
        view.animation = "slideUp"
        view.duration = 2
        view.damping = 1
        view.animate()
        return view
    }()
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.mapType = .hybridFlyover
        mapView.delegate = self
        return mapView
    }()
    private lazy var indicator: UIActivityIndicatorView = {
        let ind = UIActivityIndicatorView()
        ind.style = .large
        return ind
    }()
    private lazy var mapIndicator: UIActivityIndicatorView = {
        let ind = UIActivityIndicatorView()
        ind.style = .large
        ind.color = AppColor.title.color
        return ind
    }()
    private lazy var nameView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Country"
        view.iconImageView.setIcon(.systemName("globe"))
        return view
    }()
    private lazy var capitalView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Capital"
        view.iconImageView.setIcon(.systemName("building.columns"))
        return view
    }()
    private lazy var independencyView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Independency"
        view.iconImageView.setIcon(.systemName("flag.2.crossed.fill"))
        return view
    }()
    private lazy var areaView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Area"
        view.iconImageView.setIcon(.systemName("mappin.and.ellipse"))
        return view
    }()
    private lazy var populationView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Population"
        view.iconImageView.setIcon(.systemName("person.3.fill"))
        return view
    }()
    private lazy var startOfWeekView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Start of Week"
        view.iconImageView.setIcon(.systemName("calendar"))
        return view
    }()
    private lazy var currencyView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Currencies"
        view.iconImageView.setIcon(.systemName("dollarsign"))
        return view
    }()
    private lazy var countryCodeView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Country Code"
        view.iconImageView.setIcon(.systemName("phone.fill"))
        return view
    }()
    private lazy var timezoneView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Timezones"
        view.iconImageView.setIcon(.systemName("clock.fill"))
        return view
    }()
    private lazy var languageView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Languages"
        view.iconImageView.setIcon(.systemName("text.bubble.fill"))
        return view
    }()
    private lazy var plateCodeView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Plate Code"
        view.iconImageView.setIcon(.systemName("car.fill"))
        return view
    }()
    private lazy var trafficDirectionView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Traffic Direction"
        view.iconImageView.setIcon(.systemName("arrow.left.arrow.right"))
        return view
    }()
    private lazy var flagDescriptionView: CustomLabelView = {
        let view = CustomLabelView()
        view.titleText = "Flag Description"
        view.iconImageView.layer.borderColor = AppColor.title.color.cgColor
        view.iconImageView.layer.borderWidth = 0.2
        view.iconImageView.contentMode = .scaleToFill
        return view
    }()
    
    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        updateUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layoutSubviews()
    }
    
    private func layoutSubviews() {
        mapView.addCornerRadius(corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner,
                                          .layerMaxXMinYCorner, .layerMaxXMaxYCorner],
                                radius: 16)
        let height = timezoneView.frame.height + timezoneView.frame.origin.y
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: height)
    }
    
    // MARK: Map Function
    
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
    
    // MARK: Details & View Layout Functions
    
    private func updateUI() {
        presenter?.updateUI()
    }
    
    private func showLoadingIndicator() {
        indicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        indicator.stopAnimating()
    }
    
    private func setupViews() {
        title = AppConstants.details.text
        navigationController?.navigationBar.tintColor = AppColor.title.color
        navigationController?.navigationBar.backgroundColor = AppColor.mainBackground.color.withAlphaComponent(0.5)
        view.backgroundColor = AppColor.mainBackground.color
        view.addSubviews(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(mapView, indicator, nameView, capitalView, independencyView,
                                areaView, populationView, startOfWeekView,
                                currencyView, timezoneView, languageView,
                                plateCodeView, trafficDirectionView,
                                flagDescriptionView, countryCodeView)
        mapView.addSubview(mapIndicator)
        setupLayouts()
    }
    
    private func setupLayouts() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.3)
        }
        mapIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        indicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        nameView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        capitalView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        independencyView.snp.makeConstraints { make in
            make.top.equalTo(capitalView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        flagDescriptionView.snp.makeConstraints { make in
            make.top.equalTo(independencyView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        languageView.snp.makeConstraints { make in
            make.top.equalTo(flagDescriptionView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        countryCodeView.snp.makeConstraints { make in
            make.top.equalTo(languageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        currencyView.snp.makeConstraints { make in
            make.top.equalTo(countryCodeView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        areaView.snp.makeConstraints { make in
            make.top.equalTo(currencyView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        populationView.snp.makeConstraints { make in
            make.top.equalTo(areaView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        plateCodeView.snp.makeConstraints { make in
            make.top.equalTo(populationView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        trafficDirectionView.snp.makeConstraints { make in
            make.top.equalTo(plateCodeView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        startOfWeekView.snp.makeConstraints { make in
            make.top.equalTo(trafficDirectionView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        timezoneView.snp.makeConstraints { make in
            make.top.equalTo(startOfWeekView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: Extensions

extension DetailsViewController: UIScrollViewDelegate {}

// MARK: MapKit Functions

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
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        let coordinate = annotation.coordinate
        if coordinate.latitude == -90.0 {
            return
        }
        let coordinateRegion = MKCoordinateRegion(center: coordinate,
                                                  latitudinalMeters: 5000,
                                                  longitudinalMeters: 5000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        mapIndicator.startAnimating()
    }
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        mapIndicator.stopAnimating()
    }
}

// MARK: DetailsPresenterToView Protocol Function

extension DetailsViewController: DetailsPresenterToViewProtocol {
    func showDetails(details: Country) {
        guard let name = details.name?.official?.uppercased(),
              let flag = details.flags?.png,
              let area = details.area, 
              let areaValue = String.numberFormatter(number: area),
              let population = details.population,
              let numberOfPopulation = String.numberFormatter(number: Double(population)),
              let startOfWeek = details.startOfWeek?.rawValue.capitalized else { return }
        let capital = String.returnCapital(details: details)
        let sign = String.returnSign(details: details)
        let side = String.returnSide(details: details)
        let flagDescription = String.returnFlagDescription(details: details)
        let languages = String.returnLanguages(details: details)
        let currency = String.returnCurrencies(details: details)
        let timezone = String.returnTimezones(details: details)
        let independency = String.returnIndependency(details: details)
        let countryCode = String.returnCountryCode(details: details)
        let coordinates = Double.returnCoordinates(details: details)
        DispatchQueue.main.async { [weak self] in
            self?.showCountryOnMap(latitude: coordinates.latitude, 
                                   longitude: coordinates.longitude,
                                   title: capital)
            self?.nameView.contentText = name
            self?.capitalView.contentText = capital
            self?.independencyView.contentText = independency
            self?.flagDescriptionView.iconImageView.setIcon(.url(flag))
            self?.flagDescriptionView.contentText = flagDescription
            self?.languageView.contentText = languages
            self?.countryCodeView.contentText = countryCode
            self?.currencyView.contentText = currency
            self?.areaView.contentText = "\(areaValue) km²"
            self?.populationView.contentText = numberOfPopulation
            self?.plateCodeView.contentText = sign
            self?.trafficDirectionView.contentText = side
            self?.startOfWeekView.contentText = startOfWeek
            self?.timezoneView.contentText = timezone
        }
    }
}

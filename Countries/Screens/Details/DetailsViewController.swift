//
//  DetailsViewController.swift
//  Countries
//
//  Created by Mahmut Gazi Doğan on 19.01.2024.
//

import UIKit
import SnapKit
import MapKit

class DetailsViewController: UIViewController {
    
    var presenter: DetailsViewToPresenterProtocol?
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        mapView.layer.cornerRadius = 20
        mapView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner]
        mapView.layer.masksToBounds = true
        
        backgroundImageView.alpha = 0.1
    }
    
    /*
     name -> nativeName
     independent
     currencies
     capital
     languages
     latlng
     area
     flag?
     population
     car - signs - side ???
     timezones
     continents
     flags - alt?
     coatOfArms
     startOfWeek
     capitalInfo - latlng
     */
    
    private func setupViews() {
        view.backgroundColor = .systemYellow
        mapView.backgroundColor = .clear
        view.addSubviews(backgroundImageView, mapView)
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mapView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(300)
        }
    }
    
}

extension DetailsViewController: MKMapViewDelegate { }

extension DetailsViewController: DetailsPresenterToViewProtocol {
    
}

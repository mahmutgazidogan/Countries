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
        mapView.delegate = self
        return mapView
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial-Bold", size: 30)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var independencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial-Bold", size: 30)
        label.textAlignment = .center
        label.text = "Independent:"
        return label
    }()
    
    private lazy var capitalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial-Bold", size: 30)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var checkboxImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    private lazy var areaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial-Bold", size: 30)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var populationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial-Bold", size: 30)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var startOfWeekLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial-Bold", size: 30)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        showDetails()
    }
    
    override func viewDidLayoutSubviews() {
        checkboxImageView.layer.cornerRadius = 5
        checkboxImageView.layer.maskedCorners = [.layerMaxXMaxYCorner,
                                                 .layerMaxXMinYCorner,
                                                 .layerMinXMaxYCorner,
                                                 .layerMinXMinYCorner]
        checkboxImageView.layer.masksToBounds = true
        
        backgroundImageView.alpha = 0.25
    }
    
    
    
    private func setupViews() {
        self.navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .white
        mapView.backgroundColor = .clear
        view.addSubviews(mapView, backgroundImageView, nameLabel, capitalLabel,
                         independencyLabel, checkboxImageView, areaLabel,
                         populationLabel, startOfWeekLabel)
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
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
            make.leading.equalTo(independencyLabel.snp.trailing).offset(10)
            make.width.height.equalTo(independencyLabel.snp.height)
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
        
    }
    
}

extension DetailsViewController: MKMapViewDelegate { }

extension DetailsViewController: DetailsPresenterToViewProtocol {
    
    /*
     +++++++++name -> nativeName
     +++++++++independent
     +++++++++area
     +++++++++population
     
     capital & capitalInfo - latlng
     languages
     latlng
     flag? & flags - alt?
     car - signs - side ???
     timezones
     continents
     coatOfArms
     startOfWeek
     */
    
    func showDetails() {
        guard let details = presenter?.getDetails(),
              let independent = details.independent,
              let area = details.area,
              let areaValue = presenter?.numberFormatter(number: area),
              let population = details.population,
              let numberOfPopulation = presenter?.numberFormatter(number: Double(population)),
              let startOfWeek = details.startOfWeek?.rawValue.capitalized else { return }
        DispatchQueue.main.async {
            self.backgroundImageView.kf.setImage(with: URL(string: details.flags?.png ?? ""))
            self.nameLabel.text = details.name?.official?.uppercased()
            self.capitalLabel.text = details.capital?.first
            self.areaLabel.text = "Area: \(areaValue) km²"
            self.populationLabel.text = "Population: \(numberOfPopulation)"
            self.startOfWeekLabel.text = "Start of Week: \(startOfWeek)"
            if independent {
                self.checkboxImageView.image = UIImage(named: "tick")
            } else {
                self.checkboxImageView.image = UIImage(named: "cross")
            }
        }
    }
}



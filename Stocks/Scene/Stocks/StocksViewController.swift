//
//  StocksViewController.swift
//  Stocks
//
//  Created by Игорь Силаев on 31.08.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import UIKit

protocol StocksDisplayLogic: AnyObject {
    func displayStock(_ viewModel: StocksModels.FetchStock.ViewModel)
    func displayCompanies(_ viewModel: StocksModels.FetchCompanies.ViewModel)
}

final class StocksViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: StocksBusinessLogic!
    var router: (StocksRoutingLogic & StocksDataPassing)!
    
    // MARK: - Private Properties
    private var companyNameLabel = UILabel()
    private var companyNameStaticLabel = UILabel()
    private var companyPickerView = UIPickerView()
    private var activityIndicator = UIActivityIndicatorView()
    private var companySymbolLabel = UILabel()
    private var priceLabel = UILabel()
    private var priceChangeLabel = UILabel()
    private var companyIconImageView = UIImageView()
    
    private var companies: [[String : String]]?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        interactor.handleViewReady()
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        view.backgroundColor = .white
        
        view.addSubview(companyNameLabel)
        view.addSubview(companyNameStaticLabel)
        configureCompanyNameLabels()
        setConstraintsForCompanyNameLabels()
        
        view.addSubview(activityIndicator)
        confugireActiviteIndicator()
        setConstraintsForActiviteIndicator()
        
        view.addSubview(companyPickerView)
        configureCompanyPickerView()
        setConstraintsForCompanyPickerView()
    }
    
    private func configureCompanyNameLabels() {
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        companyNameStaticLabel.translatesAutoresizingMaskIntoConstraints = false
        companyNameStaticLabel.text = "Company name"
        companyNameLabel.text = "-"
    }
    
    private func setConstraintsForCompanyNameLabels() {
        NSLayoutConstraint.activate([
            companyNameStaticLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            companyNameStaticLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            companyNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            companyNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
    }
    
    private func confugireActiviteIndicator() { 
        activityIndicator.hidesWhenStopped = true
    }
    
    private func setConstraintsForActiviteIndicator() {
        activityIndicator.center = view.center
    }
    
    private func configureCompanyPickerView() {
        companyPickerView.translatesAutoresizingMaskIntoConstraints = false
        companyPickerView.dataSource = self
        companyPickerView.delegate = self
    }
    
    private func setConstraintsForCompanyPickerView() {
        NSLayoutConstraint.activate([
            companyPickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            companyPickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            companyPickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            companyPickerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
    }
    
}

// MARK: - Display Logic

extension StocksViewController: StocksDisplayLogic {
    func displayStock(_ viewModel: StocksModels.FetchStock.ViewModel) {
        
    }
    func displayCompanies(_ viewModel: StocksModels.FetchCompanies.ViewModel) {
        companies = viewModel.companies
        companyPickerView.reloadAllComponents()
    }
}

// MARK: - UIPickerViewDataSource

extension StocksViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let companiesCount = companies?.count else {
            return 0
        }
        return companiesCount
    }
}

// MARK: - UIPickerViewDelegate

extension StocksViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let company = companies?[row].keys.first else { return "Error"}
        return company
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //TODO: access to component
        let request = StocksModels.FetchStock.Request(symbol: "")
        interactor.requestStock(request)
    }
}

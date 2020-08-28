//
//  ViewController.swift
//  Stocks
//
//  Created by Игорь Силаев on 28.08.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyPickerView: UIPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var companySymbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    @IBOutlet weak var companyIconImageView: UIImageView!
    
    // MARK: - Private properties
    private var companies: [[String : String]]? {
        didSet {
            requestQuoteUpdate()
            companyPickerView.reloadAllComponents()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        companyPickerView.dataSource = self
        companyPickerView.delegate = self
        
        activityIndicator.hidesWhenStopped = true
        
        requestCompaniesList()
    }
    
    // MARK: - Private methods
    
    private func requestQuote(for symbol: String) {
        let token = "pk_4b1273e91976462098febe7ae10e4a9f"
        guard let url = URL(string: "https://cloud.iexapis.com/stable/stock/\(symbol)/quote?token=\(token)") else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                (response as? HTTPURLResponse)?.statusCode == 200,
                error == nil {
                self.parseQuote(from: data)
            } else {
                DispatchQueue.main.async {
                    let errorAlert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(errorAlert, animated: true, completion: nil)
                }
                print("Network error")
            }
        }
        dataTask.resume()
    }
    
    private func requestCompaniesList() {
        activityIndicator.startAnimating()
        
        let token = "pk_4b1273e91976462098febe7ae10e4a9f"
        guard let url = URL(string: "https://cloud.iexapis.com/stable/ref-data/symbols?token=\(token)") else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                (response as? HTTPURLResponse)?.statusCode == 200,
                error == nil {
                self.parseSymbols(from: data)
            } else {
                DispatchQueue.main.async {
                    let errorAlert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(errorAlert, animated: true, completion: nil)
                }
                print("Network error")
            }
        }
        dataTask.resume()
    }
    
    private func requestIcon(for symbol: String) {
        guard let url = URL(string: "https://storage.googleapis.com/iexcloud-hl37opg/api/logos/\(symbol).png") else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                (response as? HTTPURLResponse)?.statusCode == 200,
                error == nil {
                DispatchQueue.main.async {
                    self.companyIconImageView.image = UIImage(data: data)
                }
            } else {
                DispatchQueue.main.async {
                    let errorAlert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(errorAlert, animated: true, completion: nil)
                }
                print("Network error")
            }
        }
        dataTask.resume()
    }
    
    // MARK: - Parser methods
    
    private func parseQuote(from data: Data) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            
            guard
                let json = jsonObject as? [String : Any],
                let companyName = json["companyName"] as? String,
                let companySymbol = json["symbol"] as? String,
                let price = json["latestPrice"] as? Double,
                let priceChange = json["change"] as? Double else {
                    DispatchQueue.main.async {
                        let errorAlert = UIAlertController(title: "Error", message: "Stocks for company don't avaliable", preferredStyle: .alert)
                        errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(errorAlert, animated: true, completion: nil)
                    }
                    return
            }
            
            self.requestIcon(for: companySymbol)
            DispatchQueue.main.async {
                self.displayStockInfo(companyName: companyName,
                                      companySymbol: companySymbol,
                                      price: price,
                                      priceChange: priceChange)
            }
        } catch {
            print("JSON parsing error: " + error.localizedDescription)
        }
    }
    
    private func parseSymbols(from data: Data) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            var companiesList = [[String: String]]()
            
            guard
                let companies = jsonObject as? [[String : Any]] else { return print("Invalid JSON") }
            
            for company in companies {
                if let companyName = company["name"] as? String, let companySymbol = company["symbol"] as? String {
                    companiesList.append([companyName : companySymbol])
                }
            }
            
            DispatchQueue.main.async {
                self.companies = companiesList
            }
            
        } catch {
            print("JSON parsing error: " + error.localizedDescription)
        }
    }
    
    // MARK: - Display methods
    
    private func displayStockInfo(companyName: String,
                                  companySymbol: String,
                                  price: Double,
                                  priceChange: Double) {
        activityIndicator.stopAnimating()
        companyNameLabel.text = companyName
        companySymbolLabel.text = companySymbol
        priceLabel.text = "\(price)"
        priceChangeLabel.text = "\(priceChange)"
        
        if priceChange < 0 {
            priceChangeLabel.textColor = .red
        } else if priceChange > 0 {
            priceChangeLabel.textColor = .green
        } else {
            priceChangeLabel.textColor = .black
        }
    }
    
    private func requestQuoteUpdate() {
        companyNameLabel.text = "-"
        companySymbolLabel.text = "-"
        priceLabel.text = "-"
        priceChangeLabel.textColor = .black
        priceChangeLabel.text = "-"
        companyIconImageView.image = nil
        
        let selectedRow = companyPickerView.selectedRow(inComponent: 0)
        guard let selectedSymbol = companies?[selectedRow].values.first else { return }
        requestQuote(for: selectedSymbol)
    }
    
}

// MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {
    
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

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let company = companies?[row].keys.first else { return "Error"}
        return company
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        requestQuoteUpdate()
    }
}

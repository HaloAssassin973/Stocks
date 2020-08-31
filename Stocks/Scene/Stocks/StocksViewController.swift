//
//  StocksViewController.swift
//  Stocks
//
//  Created by Игорь Силаев on 31.08.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import UIKit

protocol StocksDisplayLogic: AnyObject {
    
}

final class StocksViewController: UIViewController {
    
    // MARK: - UI Outlets
    
    //
    
    // MARK: - Public Properties
    
    var interactor: StocksBusinessLogic?
    var router: (StocksRoutingLogic & StocksDataPassing)?
    
    // MARK: - Private Properties
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Public Methods
    
    //
    
    // MARK: - Requests
    
    //
    
    // MARK: - Private Methods
    
    private func configure() {
        view.backgroundColor = .white
    }
    
    // MARK: - UI Actions
    
    //
}

// MARK: - Display Logic

extension StocksViewController: StocksDisplayLogic {
    
}

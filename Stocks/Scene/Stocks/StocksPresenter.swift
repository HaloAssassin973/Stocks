//
//  StocksPresenter.swift
//  Stocks
//
//  Created by Игорь Силаев on 31.08.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import UIKit

protocol StocksPresentationLogic: AnyObject {
    func presentStock(_ response: StocksModels.FetchStock.Response)
    func presentCompanies(_ response: StocksModels.FetchCompanies.Response)
}

final class StocksPresenter {
    
    // MARK: - Public Properties
    
    weak var viewController: StocksDisplayLogic?
    
    // MARK: - Private Properties
    
}

// MARK: - Stocks presentation logic

extension StocksPresenter: StocksPresentationLogic {
    func presentStock(_ response: StocksModels.FetchStock.Response) {
        
    }
    func presentCompanies(_ response: StocksModels.FetchCompanies.Response) {
        
    }
}

//
//  StocksInteractor.swift
//  Stocks
//
//  Created by Игорь Силаев on 31.08.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import Foundation

protocol StocksBusinessLogic: AnyObject {
    func handleViewReady()
    func requestQuote(_ request: StocksModels.FetchStock.Request)
    func requestCompaniesList()
}

protocol StocksDataStore: AnyObject {
    
}

final class StocksInteractor: NSObject, StocksDataStore {
    
    // MARK: - Public Properties
    
    var presenter: StocksPresentationLogic?
    lazy var worker: StocksWorkingLogic = StocksWorker()
    
    // MARK: - Private Properties
    
    
}

// MARK: - Stocks business logic

extension StocksInteractor: StocksBusinessLogic {
    func handleViewReady() {
        requestCompaniesList()
    }
    
    func requestQuote(_ request: StocksModels.FetchStock.Request) {
        
    }
    
    func requestCompaniesList() {
        
    }
}

//
//  StocksInteractor.swift
//  Stocks
//
//  Created by Игорь Силаев on 31.08.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import Foundation

protocol StocksBusinessLogic: AnyObject {

}

protocol StocksDataStore: AnyObject {

}

final class StocksInteractor: NSObject, StocksDataStore {

  // MARK: - Public Properties

  var presenter: StocksPresentationLogic?
  lazy var worker: StocksWorkingLogic = StocksWorker()

  // MARK: - Private Properties
  
  //

  // MARK: - Business Logic
  
  //
}

// MARK: - Stocks presentation logic

extension StocksInteractor: StocksBusinessLogic {
    
}

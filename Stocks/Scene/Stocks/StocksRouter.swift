//
//  StocksRouter.swift
//  Stocks
//
//  Created by Игорь Силаев on 31.08.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import UIKit

protocol StocksRoutingLogic: AnyObject {
    
}

protocol StocksDataPassing {
    var dataStore: StocksDataStore? { get }
}

final class StocksRouter: StocksDataPassing {
    
    // MARK: - Public Properties
    
    weak var viewController: StocksViewController?
    var dataStore: StocksDataStore?
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Routing Logic
    
    //
    
    // MARK: - Navigation
    
    //
    
    // MARK: - Passing data
    
    //
}

// MARK: - Stocks routing logic

extension StocksRouter: StocksRoutingLogic {
    
}

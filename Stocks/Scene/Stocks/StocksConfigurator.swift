//
//  StocksConfigurator.swift
//  Stocks
//
//  Created by Игорь Силаев on 31.08.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import UIKit

final class StocksConfigurator {
    
    static func build(viewController: StocksViewController) {
        
        let presenter = StocksPresenter()
        presenter.viewController = viewController
        
        let interactor = StocksInteractor()
        interactor.presenter = presenter
        
        let router = StocksRouter()
        router.viewController = viewController
        router.dataStore = interactor
        
        viewController.interactor = interactor
        viewController.router = router
    }
}

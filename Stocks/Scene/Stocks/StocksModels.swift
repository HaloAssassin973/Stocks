//
//  StocksModels.swift
//  Stocks
//
//  Created by Игорь Силаев on 31.08.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import UIKit

enum StocksModels {
    
    enum FetchStock {
        struct Request {
            let symbol: String
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }
    
    enum FetchCompanies {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
            let companies: [[String : String]]
        }
    }
}

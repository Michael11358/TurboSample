//
//  AccountingSummariesViewModel.swift
//  TurboSample
//
//  Created by Voline, Michael on 2020-02-07.
//  Copyright © 2020 MihaVoline. All rights reserved.
//

import UIKit

struct AccountingSummariesViewModel {
    
    var viewModels: [SummaryViewModel]
    
    /// Height of all summaries
    var height: CGFloat {
        viewModels.reduce(0) { $0 + $1.height }
    }
    
    struct SummaryViewModel {
         var text: String
         let height: CGFloat
         let color: UIColor
     }
}

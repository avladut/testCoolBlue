//
//  DatasourceUpdateProtocol.swift
//  CoolBlueTest
//
//  Created by Alexandru Vladut on 17/07/2018.
//  Copyright © 2018 Alexandru Vladut. All rights reserved.
//

import Foundation
protocol DatasourceUpdateDelegate : class {
    func updateDatasource()
    func updateDatasourceFailed(errorMessage:String)
}

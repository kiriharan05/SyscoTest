//
//  APIResponse.swift
//  SyscoTest
//
//  Created by ADL on 2022-06-06.
//

import Foundation

class PlanetViewModel{
    var count: Int?
    var next: String?
    var previous: String?
    var planetsApiResultsModel: PlanetsApiResultsModel
    
    init(_ model: PlanetsApiResultsModel? , count: Int?, next: String?, previous: String?) {
        self.count = count
        self.next  = next
        self.previous = previous
        self.planetsApiResultsModel = model!
    }
}


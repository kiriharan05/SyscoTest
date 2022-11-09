//
//  PlanetsApiModel.swift
//  SyscoTest
//
//  Created by ADL on 2022-11-09.
//

import Foundation
import ObjectMapper

class PlanetsApiModel: Mappable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [PlanetsApiResultsModel]?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        next <- map["next"]
        previous <- map["previous"]
        results <- map["results"]
    }
}

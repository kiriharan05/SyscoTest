//
//  APIResponse.swift
//  SyscoTest
//
//  Created by ADL on 2022-06-06.
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

class PlanetsApiResultsModel: Mappable {
    var name: String?
    var rotation_period: String?
    var orbital_period: String?
    var diameter: String?
    var climate: String?
    var gravity: String?
    var terrain: String?
    var surface_water: String?
    var population: String?
    var next: String?
    var residents: [String]?
    var films: [String]?
    var created: String?
    var previous: String?
    var edited: String?
    var url: String?

    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        rotation_period <- map["rotation_period"]
        orbital_period <- map["orbital_period"]
        diameter <- map["diameter"]
        climate <- map["climate"]
        gravity <- map["gravity"]
        terrain <- map["terrain"]
        surface_water <- map["surface_water"]
        population <- map["population"]
        residents <- map["residents"]
        films <- map["films"]
        created <- map["created"]
        edited <- map["edited"]
        url <- map["url"]
    }
}

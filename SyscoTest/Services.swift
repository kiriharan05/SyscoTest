//
//  Services.swift
//  SyscoTest
//
//  Created by ADL on 2022-06-06.
//

import Foundation
import Alamofire
import ObjectMapper

class Services: BaseService {
    func getNextPlanetData(path:String? , success: @escaping ((_ planetData: PlanetsApiModel?) -> Void), faliure: (@escaping(_ error: Error?) -> Void)){
        var url: String?
        
        if path != nil {
            url =  path!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        } else {
            url = ("\(Hosts.baseUrl.rawValue)/planets").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        }
        
        var request: AlamofireRequestModal = AlamofireRequestModal()
        request.method = .get
        request.path = url!
        request.encoding = JSONEncoding.default
        
        BaseService().callWebServiceAlamofire(request, success: { response in
            let data = Mapper<PlanetsApiModel>().map(JSONObject: response)
            success(data)
        }, failure: { error in
            faliure(error)
        })
    }
}

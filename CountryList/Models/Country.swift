//
//  Country.swift
//  CountryList
//
//  Created by HiveMacBook2012 on 1/1/20.
//

import Foundation

struct Country {
    var name = String()
    var flag = String()
    var cioc = String()
    var capital = String()
    var alphaCode = String()
    var population = String()
    
    init(_ json: [String: Any]) {
        self.name = json["name"] as? String ??  ""
        self.flag = json["flag"] as? String ??  ""
        self.cioc = json["cioc"] as? String ??  ""
        self.capital = json["capital"] as? String ??  ""
        self.alphaCode = "\(json["alpha2Code"] as? String ??  ""),  \(json["alpha3Code"] as? String ??  "")"
        let populationInt = json["population"] as? Int ?? 0
        self.population = populationInt == 0 ? "" : "\(populationInt)"
    }
}

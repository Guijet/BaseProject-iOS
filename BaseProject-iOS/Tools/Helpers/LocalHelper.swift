//
//  CountryHelpers.swift
//  InfluenceMe
//
//  Created by Guillaume Jette on 2018-04-07.
//  Copyright © 2018 Guillaume Jette. All rights reserved.
//

import UIKit


class LocalHelper{
    static let shared : LocalHelper = {
        let instance = LocalHelper()
        return instance
    }()
    
    func getCountriesList()->[String]{
        var countries: [String] = []
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
        }
        return countries.sorted(by: {$0 < $1})
    }
}

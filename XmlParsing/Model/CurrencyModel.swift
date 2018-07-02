//
//  CurrencyModel.swift
//  XmlParsing
//
//  Created by Biken Maharjan on 6/26/18.
//  Copyright © 2018 Biken Maharjan. All rights reserved.
//

import UIKit
import Alamofire

import SwiftyXMLParser

// MARK:- New Model 
struct CurrencyModel: Codable{
    
    var name:String
    var price:Float
    var symbol:String
    var ts:Float
    var type:String
    var time:String
    var volume:Int
    
    
    enum codable_key: String, CodingKey{
        
        case name
        case price
        case symbol
        case ts 
        case type
        case time = "utctime"
        case volume
        
    }
}





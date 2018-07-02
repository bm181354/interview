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
///////////////////////////////////////////////
// MARK:- old model
// apple's default way to work with XML
struct Resource{
    
    var name:String
    var price:String
    var symbol:String
    var ts:String?
    var type:String
    var date:String
    var volume:String
    
}
// MARK:- Netowking
extension Resource{
    
    // MARK:- fetch data [Newtorking]
    static func fetchData(symbol:String, done: @escaping (Bool,Any,Any)->Void){
        #if DEBUG
         print("Fetch")
        #endif
        
        let url = "https://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote"
        var resources:[Resource] = [Resource]()
        
        Alamofire.request(url)
            .responseData(completionHandler: {(response) in
                
                if let data = response.data {
                    let xml = XML.parse(data)
                    for resource in xml["list","resources","resource"]{
                        
                        
                        if let name = resource["field",0].text,
                            let price = resource["field",1].text,
                            let symbol = resource["field",2].text,
                            let ts = resource["field",3].text,
                            let type = resource["field",4].text,
                            let utc = resource["field",5].text,
                            let volume = resource["field",6].text {
                            let resource = Resource(name: name,price: price,symbol: symbol,ts: ts,
                                                    type: type,date: utc,volume: volume)
                            
                            resources.append(resource)
                        }
                        
                    }
                    
                    DispatchQueue.main.async{
                        done(true,resources,"No Error")
                    }
                    
                }else{
                    DispatchQueue.main.async{
                        done(false,"No data",response.error as Any)
                    }
                }
                
            })
        
    }
    
}
///////////////////////////////////////////////
enum customError:Error{
    case fieldError(err:String)
    case novalueError
}




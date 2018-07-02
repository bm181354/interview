//
//  Resource.swift
//  XmlParsing
//
//  Created by Biken Maharjan on 7/2/18.
//  Copyright © 2018 Biken Maharjan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyXMLParser
import CoreData

///////////////////////////////////////////////
// MARK:- old model
// apple's default way to work with XML
// MARK:- Netowking
extension Resource{
    // MARK:- fetch data [Newtorking]
    static func loadData(symbol:String, done: @escaping (Bool,Any,Any)->Void){
        
        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        let context = container.viewContext
        
        #if DEBUG
        print("Load")
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
                            
                            
                            let resource = Resource(context: context)
                            resource.date = utc
                            resource.name = name
                            resource.price = price
                            resource.symbol = symbol
                            resource.type = ts
                            resource.volume = volume
                            
                            try! context.save() 
                            
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
extension Resource{
    public static func ==(lhs: Resource,rhs:Resource) -> Bool{
        return lhs ==  rhs
    }
}
///////////////////////////////////////////////
enum customError:Error{
    case fieldError(err:String)
    case novalueError
    case noIndex
}
///////////////////////////////////////////////



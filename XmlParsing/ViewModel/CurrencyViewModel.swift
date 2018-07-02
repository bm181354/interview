//
//  CurrencyViewModel.swift
//  XmlParsing
//
//  Created by Biken Maharjan on 7/2/18.
//  Copyright © 2018 Biken Maharjan. All rights reserved.
//

import UIKit

class CurrencyViewModel{
    
    var collection:[Resource] = []
    
    func addValue(resource: Resource){
        collection.append(resource)
    }
    
    func removeValue(resource: Resource) throws {
        // find the index
        guard let  index = collection.index(of: resource) else {
            throw customError.novalueError
        }
        // if there then REMOVE
        collection.remove(at: index)
    }
    
    func count()->Int{
         return collection.count
    }
    
    func search(symbol:String,resources:[Resource]?) throws-> String{
        
        guard let resources = resources else {throw customError.novalueError}
        
        var res:Resource?
        for resource in resources{
            
            if resource.symbol == symbol {
                res = resource
                // change the loop
                return (resource.symbol!.split(separator:"=")[0]+": ") + res!.price!
            }
        }
        throw customError.novalueError
    }
    
    func loadData(text: String = "INR=X",completion:@escaping (Bool,Any)->()){
        Resource.fetchData(symbol: "CNY=X", done: { [weak self] (isSuccess,data,error)->() in
            if (isSuccess){
                self?.collection = (data as? [Resource])!
                if let result = try? self?.search(symbol:text,resources: data as? [Resource]){
                      //self?.lbName.text =  result!
                       completion(true,result!)
                }else {
                      //self?.lbName.text = "No result"
                       completion(false,"none")
                }
            }
        })
    }
    
 
}

//
//  CurrencyViewModel.swift
//  XmlParsing
//
//  Created by Biken Maharjan on 7/2/18.
//  Copyright © 2018 Biken Maharjan. All rights reserved.
//

import UIKit
import CoreData

class CurrencyViewModel{
    
    var collection:[Resource] = []
    
    
    init() {
        
    }
    
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
        
        // check whether request has data or not
        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        let context = container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Resource")
        
        // if it has element then use this
        let count  = try! context.count(for: request)
        print(count)

        if count > 0 {
             let data = try! self.fetchCoreData()
            if let result = try? self.search(symbol:text,resources: data as? [Resource]){
               
                completion(true,result)
                print("result from coredata")
            }else {
               
                completion(false,"none")
            }
        } else {
        //else
        Resource.loadData(symbol: "CNY=X", done: { [weak self] (isSuccess,data,error)->() in
            if (isSuccess){
                // load data
                let data = try! self?.fetchCoreData()
                self?.collection = (data)!
                if let result = try? self?.search(symbol:text,resources: data as? [Resource]){
                    
                       completion(true,result!)
                      print("from web")
                }else {
                    
                       completion(false,"none")
                }
            }
        })
    }
        
    }
    
    func fetchCoreData()throws->[Resource]{
        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        let context = container.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Resource")
        
            if let result = try? context.fetch(request)
            {
                print(result)
                // package list of Resource
                return result as! [Resource]
            }else {throw customError.noIndex}
           
     }

}

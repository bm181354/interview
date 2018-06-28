//
//  ViewController.swift
//  XmlParsing
//
//  Created by Biken Maharjan on 6/26/18.
//  Copyright © 2018 Biken Maharjan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyXMLParser


class ViewController: UIViewController {

    fileprivate var resourcesList:[Resource]?
    fileprivate var resource:Resource?
    
    @IBOutlet weak var tvText: UITextField!
    @IBOutlet weak var lbName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnRequest(_ sender: Any) {
        let text = tvText.text!
        
        fetchData(symbol: "CNY=X", done: { [weak self] (data)->() in
            self?.resourcesList = data as? [Resource]
            
            if let result = try? self?.search(symbol:text){
                self?.lbName.text = result!
            }else {
                self?.lbName.text = "NO result"
            }
        })
    }

    // MARK:- fetch data [Newtorking]
    func fetchData(symbol:String, done: @escaping (Any)->Void){
        
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
                        done(resources)
                    }

                }
                
            })
    
    }

}
////////////////////////////////////////////////////////////////////////////

// Conforms to XMLParserDelegate
extension ViewController {
   
    func search(symbol:String) throws-> String{
        
        guard let resources = resourcesList else {throw customError.novalueError}
        
        var res:Resource?
        for resource in resources{
            
            if resource.symbol == symbol {
                res = resource
                return res!.price
            }
        }
        
         throw customError.novalueError
        
     }
   
}


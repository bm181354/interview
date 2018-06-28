//
//  ViewController.swift
//  XmlParsing
//
//  Created by Biken Maharjan on 6/26/18.
//  Copyright © 2018 Biken Maharjan. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    fileprivate var resourcesList:[Resource]?
    fileprivate var resource:Resource?
    
    @IBOutlet weak var ivDollar: UIImageView!
    @IBOutlet weak var tvText: UITextField!
    @IBOutlet weak var lbName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
    }
    
}

//MARK:- Additional methods
extension ViewController {
   
    func search(symbol:String,resources:[Resource]?) throws-> String{
        
        guard let resources = resources else {throw customError.novalueError}
        
        var res:Resource?
        for resource in resources{
            
            if resource.symbol == symbol {
                res = resource
                return (resource.symbol.split(separator:"=")[0]+": ") + res!.price
            }
        }
         throw customError.novalueError
     }
    
    
    // MARK:- Action
    @IBAction func btnRequest(_ sender: Any) {
        let text = tvText.text!
        
        Resource.fetchData(symbol: "CNY=X", done: { [weak self] (isSuccess,data,error)->() in
            if (isSuccess){
                self?.resourcesList = data as? [Resource]
                if let result = try? self?.search(symbol:text,resources: data as? [Resource]){
                    self?.lbName.text =  result!
                }else {
                    self?.lbName.text = "No result"
                    
                    
            
                }
            }else{
                print(error as! Error)
            }
        })
    }
    
    //MARK:- navbar
    func setNavBar(){
        navigationItem.title = "Home"
    }
   
}


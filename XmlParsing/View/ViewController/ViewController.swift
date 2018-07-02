//
//  ViewController.swift
//  XmlParsing
//
//  Created by Biken Maharjan on 6/26/18.
//  Copyright © 2018 Biken Maharjan. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    private var currencyCollection = CurrencyViewModel()
    
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

    // MARK:- Action
    @IBAction func btnRequest(_ sender: Any) {
        
        let text = tvText.text!
        currencyCollection.loadData(text: text) { [weak self] (isSuccess, data) in
            
            if let text = data as? String{
                self?.lbName.text =  text
            }
  
        }
    }
    
    //MARK:- navbar
    func setNavBar(){
        navigationItem.title = "Home"
    }
   
}


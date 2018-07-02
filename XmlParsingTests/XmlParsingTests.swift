//
//  XmlParsingTests.swift
//  XmlParsingTests
//
//  Created by Biken Maharjan on 6/26/18.
//  Copyright © 2018 Biken Maharjan. All rights reserved.
//

import XCTest
@testable import XmlParsing

class XmlParsingTests: XCTestCase {
    
    var currencyVM:CurrencyViewModel!
    
    override func setUp() {
        super.setUp()
          currencyVM = CurrencyViewModel()
          loadData()
        }
   
    // this needs expectation
    func loadData(){
        
        // create exp
        
        // load
      

        // exp rule
        
    }
    
    func testCount(){
        XCTAssert(currencyVM.count() == 0)
    }
    
    
    
}

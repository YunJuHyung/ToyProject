//
//  mainTestBundle.swift
//  mainTestBundle
//
//  Created by 윤주형 on 7/1/24.
//

import XCTest

final class mainTestBundle: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMathLogin() throws {
        
        //Given
        let param: Int = 30
        let param2: Int = 10
        //When
        let resultAdd = mathFunction().add(firstNum: param, secondNum: param2)
        let resultSubtract = mathFunction().subtract(firstNum: param, secondNum: param2)
        let resultMultiply = mathFunction().multiply(firstNum: param, secondNum: param2)
        let resultDevide = mathFunction().devide(firstNum: param, secondNum: param2)
        //Then
        
        XCTAssertEqual(resultAdd, 40, "오류 발생")
        XCTAssertEqual(resultSubtract, 20, "오류 발생")
        XCTAssertEqual(resultMultiply, 300, "오류 발생")
        XCTAssertEqual(resultDevide, 3, "오류 발생")
        
        
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

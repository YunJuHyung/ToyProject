//
//  main.swift
//  My own practice field
//
//  Created by 윤주형 on 9/19/24.
//

import Foundation

class StepCounter {
    var totalSteps: Int = 0 {
        
        willSet(newTotalSteps) {
            print("totalSet \(totalSteps)")
            print("1")
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            print("2")
            print("didSet \(totalSteps)")
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200

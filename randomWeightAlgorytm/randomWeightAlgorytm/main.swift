//
//  main.swift
//  randomWeightAlgorytm
//
//  Created by 윤주형 on 7/5/24.
//

import Foundation

var menuDictionary: [String: Double] = [
    "피자": 100.0,
    "버거": 100.0,
    "스시": 100.0,
    "파스타": 100.0,
    "샐러드": 100.0
]


// 랜덤 가중치 구하는 계산법
// value의 func reduce를 사용해 0번째 index에서 시작해 배열의 끝까지 plus함
// 전체 확률 가중치 중 랜덤 값을 정함

//누적 가중치 변수 선언을 한뒤 for문으로 dictionary 각 요소의 value값을 누적 가중치에 더해준다
//누적가중치에 더해 randomValue보다 높게되면 해당 menu를 반환한다
func selectMenuBasedOnWeight(_ menuDictionary: [String: Double]) -> String? {
    let totalWeight = menuDictionary.values.reduce(0, +)
    let randomValue = Double.random(in: 0..<totalWeight) //0...479
    
    var cumulativeWeight: Double = 0.0
    for (menu, weight) in menuDictionary {
        cumulativeWeight += weight
        if randomValue < cumulativeWeight {
            return menu
        }
    }
    return nil
}
//가중치 조절 함수
//inout 키워드는 이 파라미터가 참조 타입으로 전달된다는 것을 의미합니다. 즉, 함수 내에서 이 딕셔너리를 수정하면 호출한 곳에서도 변경 사항이 반영됩니다.
//inout을 사용하면 함수 내에서 파라미터의 값을 변경하고, 그 변경된 값을 함수 호출이 끝난 후에도 유지할 수 있습니다.
func adjustProbability(for selectedMenu: String, in menuDictionary: inout [String: Double]) {
    if let selectedMenuWeight = menuDictionary[selectedMenu] {
        if selectedMenuWeight == 20 {
            menuDictionary[selectedMenu] = 100
            print("\(selectedMenu)가 선택되어 가중치 확률을 100%로 돌립니다\n")
        } else {
            menuDictionary[selectedMenu]! -= 20
        }
    }
}

var programRunning = true
var count = 0

//while문을 돌려서 선택된 메뉴를 알수있다.
while programRunning {
    if let selectedMenu = selectMenuBasedOnWeight(menuDictionary) {
        print("\(count + 1)번째 선택된 메뉴는: \(selectedMenu)")
        print("뽑힌 메뉴의 확률은: \(menuDictionary[selectedMenu]!)")
        
        adjustProbability(for: selectedMenu, in: &menuDictionary)
        print("현재 확률: \(menuDictionary)")
        
        count += 1
        
       
            print("\n다음 뽑기를 진행합니다.\n")
       
        
        print("계속하려면 아무 키나 입력하세요. 종료하려면 'end'를 입력하세요:")
        if let userInput = readLine(), userInput.lowercased() == "end" {
            programRunning = false
        }
    }
}

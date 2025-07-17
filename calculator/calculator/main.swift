//
//  main.swift
//  calculator
//
//  Created by 윤주형 on 6/26/24.
//

import Foundation

var endWhile: Bool = true
var patternRecord: [String] = []

func main() {
    
    print("Hello, World!")
    print("계산기 프로그램이 실행되었다!")
    print("[메뉴모드]에 진입되었습니다!")
    
    while endWhile {
        print("메뉴를 선택해주세요! / calculate[계산], record[기록], exit[종료]")
        print("====================================")
        
        let userinput = readLine()
        
        switch userinput {
            
        case "exit":
            print("프로그램 종료!")
            endWhile = false
            break
            
        case "calculate":
            print("[계산]이 선택되었습니다.")
            print("[계산모드]에 진입되었습니다!")
            print("수를 입렵해주세요!")
            //첫번째 수롤 계산할 func에 넣기위해 변수저장
            if let Num1 = Int(readLine() ?? "Num1 잘못된 값을 입력하였습니다"){
                
                
                print("계산을 선택해주세요!")
                print("add[덧셈], subtract[뺄셈], multiply[곱셈], devide[나눗셈]")
                
                //연산을 계산할 func에 넣기위해 변수 저장
                let calculateOper = readLine()
                
                print("나머지 수 입력해주세요!")
                if let Num2 = Int(readLine() ?? "Num2 잘못된 값을 입력하였습니다"){
                    
                    var result: Int = 0
                    var operationSymbol: String = ""
                    var XpassedLine53: Bool = true
                    
                    switch calculateOper {
                    case "add":
                        result = mathFunction().add(firstNum: Num1, secondNum: Num2)/*add(firstNum: Num1, secondNum: Num2)*/
                        operationSymbol = "+"
                    case "subtract":
                        result = mathFunction().subtract(firstNum: Num1, secondNum: Num2)
                        operationSymbol = "-"
                    case "multiply":
                        result = mathFunction().multiply(firstNum: Num1, secondNum: Num2)
                        operationSymbol = "X"
                    case "devide":
                        result = mathFunction().devide(firstNum: Num1, secondNum: Num2)
                        operationSymbol = "÷"
                        
                    case .none:
                        print("value is nil")
                    case let .some(value):
                        print("\(value)은 잘못된 계산식입니다")
                        XpassedLine53 = false
                        
                    }
                    if XpassedLine53 == true {
                        let wordStr = ("\(Num1) \(operationSymbol) \(Num2) = \(result)")
                        print("계산 결과 입니다: \(wordStr)")
                        patternRecord.append(wordStr + "\n")
                    }
                    else {
                        print("*계산식에 오류가 있습니다.*")
                    }
                }
                else {
                    print("*가이드를 정확히 따라주새요.*")
                }
            }
            else {
                print("!!잘못된 입력으로 [메뉴]으로 돌아갑니다.!!")
            }
                

        case "record":
            print("\n기록을 확인합니다.")
            
            if patternRecord.count == 0{
                print("보여줄 기록 데이터가 없어서 [메뉴]로 돌아갑니다.")
                break
            }
            
            recordForLoop()
            print("기록 액션을 선택해주세요!")
            print("removeItem[특정 기록 삭제], removeAll[모든 기록 삭제], menu[메뉴로 이동]")
            
            let userinput = readLine()
            
            switch userinput {
            case "removeItem":
                recordForLoop()
                print("삭제할 데이터 번호를 입력해주세요.")
                
                if let deleteDateNum = Int(readLine()!){
                    patternRecord.remove(at: deleteDateNum - 1)
                    
                    
                    print("\n기록을 확인합니다.")
                    
                    recordForLoop()
                    
                }
            case "removeAll":
                print("모든 기록을 삭제합니다.")
                patternRecord.removeAll()
            case "menu":
                print("[메뉴]로 이동합니다.")
                break
            case .none:
                print("Optional is nil")
            case .some(_):
                print("잘못되 입력으로 [메뉴]로 돌아갑니다")
            }
            //기록된 계산식을 출력 저장된 배열 출력
        case .none:
            print("Optional is nil")
        case .some(_):
            print("!!제대로된 메뉴를 선택해주세요!!")
        }
    }
}

// MARK: -- func dictionary

/// 사칙연산 모음
struct mathFunction {
    
    func add(firstNum: Int, secondNum: Int) -> Int{
        let answer = firstNum + secondNum
        return answer
    }
    
    
    func subtract(firstNum: Int, secondNum: Int) -> Int{
        let answer = firstNum - secondNum
        return answer
    }
    
    func multiply(firstNum: Int, secondNum: Int) -> Int{
        let answer = firstNum * secondNum
        return answer
    }
    
    func devide(firstNum: Int, secondNum: Int) -> Int{
        let answer = firstNum / secondNum
        return answer
    }
}

/// record입력시 배열을 출력하는 반복문
fileprivate func recordForLoop() {
    patternRecord.enumerated().forEach { count, Result in
        print("[\(count + 1)] \(Result)")
    }
}


main()

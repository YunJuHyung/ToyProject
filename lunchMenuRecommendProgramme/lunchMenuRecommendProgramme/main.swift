//
//  main.swift
//  lunchMenuRecommendProgramme
//
//  Created by 윤주형 on 7/3/24.
//


//

import Foundation
var secondMenuCategories: [String] = []
var count = 0
var recorded: [(String,Date)] = []

func returnDate() -> Date {
    let date = Date()
    return date
}




func main() {
    
    var programRunning: Bool = true
    var startPoints: Bool = true
    
    var MenuCategories: [String] = []
    
    var count = 1
    
    
    
//    let arrayLength = MenuCategories.count - 1
    
    print("점심 메뉴 추천 프로그램을 실행합니다.")
    while startPoints {
        print("메뉴의 번호를 선택해주세요.")
        print("1. [점심 메뉴 추가] 2. [랜덤돌리기] 3. [기록 확인] 4. 어디서든 exit 입력시 [종료]입니다.")
        
        
        let mainSelection = readLine()
        switch mainSelection {
        case "1":
            print("[점심 메뉴 추가]를 선택했습니다.")
            print("추가할 점심 메뉴를 입력해주세요.")
            
            while let MenuInput = readLine() {
                
                if MenuInput == "end" {
                    break
                }
                MenuCategories.append(MenuInput)
                let set = Set(MenuCategories)
                if count >= 2 && MenuCategories.count != set.count {
                    print("이미 있는 메뉴입니다.")
                    MenuCategories.remove(at: MenuCategories.count - 1)
                } else {
                    print("\(count)번째 메뉴: \(MenuInput)")
                    count += 1
                }
                    print("완료됐다면 end를 입력해주세요.")

            }
            secondMenuCategories = MenuCategories
            count = 1
            
        case "2":
            
            /*반복문*/
            //로직 설명 n개의 값을 100에서 나누고 나눈 몫을 각 값에 부여 Roll
            //한번 롤 할때 선택된 값의 확률에서 x 몫/100 16%가됨
            //다른 값의 확률에 더하기 = 빠진 퍼센트를 / 총 값의 갯수 - 1
            
            if MenuCategories.isEmpty {
                print("점심 메뉴를 추가하고 돌려주세요!")
                break
            }
            print("[랜덤 돌리기]를 선택했습니다.")
            print("3..."); do { sleep(1)}; print("2.."); do { sleep(1)};  print("1."); do { sleep(1)}
            
            var MenuDictionary: [String: Double] = [:]
            for index in MenuCategories{ //메뉴가 들어간 배열을 돌면서 차례대로 dictionary에 값을 넣어줌
                MenuDictionary[index] = Double(100.0)
            }
            
            //MARK: 랜덤 가중치 구하는 계산법
            // values의 func reduce를 사용해 0번째 index에서 시작해 배열의 끝까지 plus함
            // 전체 확률 가중치 중 랜덤 값을 정함

            //누적 가중치 변수 선언을 한뒤 for문으로 dictionary 각 요소의 value값을 누적 가중치에 더해준다
            //누적가중치에 더해 randomValue보다 높게되면 해당 menu를 반환한다
            
            func weightRandomPicker(MenuDictionary: [String: Double]) -> String {
                let totalValueAmount = MenuDictionary.values.reduce(0, +)
                let randomPinLocation = Double.random(in: 0...totalValueAmount)
                
                var cumulativeWeight: Double = 0.0
                for (menu, value) in MenuDictionary {
                    cumulativeWeight += value //초기화 에러 'cumulativeWeight' passed by reference before being initialized
                    if randomPinLocation < cumulativeWeight {
                        
                        return menu
                    }
                }
                return "말이 안되는 경우 발생 \(randomPinLocation) == \(cumulativeWeight)" // 에러 처리 해줘야됨
            }

            //MARK: 가중치 조절 함수
            //inout 키워드는 이 파라미터가 참조 타입으로 전달된다는 것을 의미합니다. 즉, 함수 내에서 이 딕셔너리를 수정하면 호출한 곳에서도 변경 사항이 반영됩니다.
            //inout을 사용하면 함수 내에서 파라미터의 값을 변경하고, 그 변경된 값을 함수 호출이 끝난 후에도 유지할 수 있습니다.
            
            func decreaseWeightWhenSelected(selectedMenu: String, dictionary: inout [String: Double]){
                if let selectedValue = dictionary[selectedMenu] {
                    if selectedValue == 20 {
                        print("선택한 \(selectedMenu)의 가중치가 0이되어 100으로 리셋합니다.")
                        dictionary[selectedMenu] = 100
                    } else {
                        dictionary[selectedMenu]! -= 20.0
                    }
                }
            }
            
            //MARK: 기록 저장 함수
            
            func MenuIndicator(selectedMenu: String, MenuDictionary: [String:Double], count: Int) -> (String, Date){
                
                let literal = "뽑힌 메뉴는:\(selectedMenu), 확률은: \(MenuDictionary)입니다."
                let currentDate = Date()
                print(literal)
                return (literal, currentDate)

            }
            
            
        

            while programRunning {
                        // 뽑힌 메뉴는 기존 확률의 20%씩 낮추춤
//                        MenuDictionary[selectedMenu] = -20
                        //selectedMenuValueDecrease origin확률을 20% 낮춘값
                        /** 진짜 놀라운 사실 딕셔너리의 key 값을 넣어줘서 value값이 튀어나오는 거같음**/

                let selectedMenu = weightRandomPicker(MenuDictionary: MenuDictionary)
                
                    //&inout 표시
                decreaseWeightWhenSelected(selectedMenu: selectedMenu, dictionary: &MenuDictionary)
                
//                for index in MenuDictionary {
//                    if selectedMenu == MenuDictionary[index] {
//                        
//                    }
//                }
               
                
                print("==================================")
                
                let (resultString, date) = MenuIndicator(selectedMenu: selectedMenu, MenuDictionary: MenuDictionary, count: count)
                recorded.append((resultString, date))
                
                
                    print("종료하고 싶으면 end를 입력해주세요")
                    let getEndPoint = readLine()
                        
                        if getEndPoint == "end" {
                            programRunning = false
                        }
            } // while programmingRunning
            
        case "3":
            print("기록확인")
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분 ss초"
            
            for (String, values) in recorded {
                let result = formatter.string(from: values)

                print("\(String) 시간은 \(result)입니다.")
            }
            
            
            //timeWithRecord(recorded: recorded)
            
            
        default:
            if mainSelection == "exit" {
                print("프로그램을 종료합니다.")
                startPoints = false
            }
        }
    }
}

main()

//              MARK: original 점메추 프로그램
//              기존 배열의 내용을 하나씩 없애는 case:2
//                if MenuCategories.isEmpty {
//                    print("**더이상 추천 메뉴가 없습니다. 초기 상태로 돌립니다.**\n")
//                    MenuCategories = secondMenuCategories
//                    count = 1
//                }
//
//                if let Menu = MenuCategories.indices.randomElement(){
//
//                    let removedString = MenuCategories[Menu]
//                    MenuCategories.remove(at: Menu)
//
//                    print("======= 룰렛을 돌립니다 =======\n")
//                    do { sleep(1)}
//                    print("********************************")
//                    print("\(count)번째 추천 점심 메뉴는 \(removedString)입니다.")
//                    print("********************************\n")
//                    do { sleep(1)}
//
//                    var collectInput: Bool = true
//                    while collectInput {
//                        print("원치 않는 메뉴이면 roll을 만족하면 end를 입력해주세요")
//                        let userInput = readLine()
//                        if userInput == "roll" {
//                            count += 1
//                            collectInput = false
//                        }
//                        else if userInput == "end"{
//                            print("\(removedString) 먹으러 가자")
//                            programRunning = false
//                            collectInput = false
//                        }
//                        else {
//                            print("제대로 입력해주세요.")
//                        }
//                    }
//                }



//            //100% / 전체메뉴갯수(n) == 100% / 메뉴가5개 = 각 메뉴당 초기확률 20%
//            // 착각하지말자 eachMenuDefaultPercentage는 100퍼센트의 확률 / 배열의 갯수
//           let eachMenuDefaultPercentage = 100 / MenuCategories.count
//            //dictionary를 사용해서 [메뉴 : 확률] 저장
//            var MenuDictionary: [String: Double] = [:]
//            for index in MenuCategories{
//                MenuDictionary[index] = Double(eachMenuDefaultPercentage)
//            }
//            //새로운 사실 dictionary는 순서대로 저장되지 않는다.


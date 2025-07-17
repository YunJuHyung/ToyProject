//
//  main.swift
//  NameRecommandApp
//
//  Created by 윤주형 on 7/10/24.
//

import Foundation

struct jsonFile:Codable {
    var msg: String
    var code: String
    var data: String
}

var programRunning: Bool = true
let pick1: String = "pick1"
let pick2: String = "pick2"
let exit: String = "exit"
let result: String = "result"
var arrayInputString: String = ""
var date = Date()
var pick1Array: [(String,String)] = []
var dual: [(String,String)] = []

func main() {
    var totalCountNum = 0
    
    
    print("이름 추천 프로그램 만들기")
    print("===================================")
    while programRunning {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분 ss초"
        print("안녕하세요?! 메뉴를 입력해주세요![pick1]: 랜덤이름뽑기1회 [pick2]: 랜덤이름 뽑기n회, [result]: 뽑기 기록보기 [exit]: 종료")
        
        
        let userInput = readLine()
        if exit == userInput {
            programRunning = false
        }
        if pick1 == userInput {
            (date,arrayInputString) = getRandomName(userInput: pick2)
            
            let V1 = formatter.string(from: date)
            let V2 = arrayInputString
            
            pick1Array.append((V1, V2))
            print("- 뽑힌 시간은: \(V1), 뽑힌 이름은: \(V2)입니다.")
            totalCountNum += 1
        }
        if pick2 == userInput {
            print("몇개의 이름을 얻을것인지 입력하세요:")
            if let countTimes = Int(readLine() ?? "not converted") {
                
                for _ in 1...countTimes {
                    (date,arrayInputString) = getRandomName(userInput: pick2)
                    
                    let V1 = formatter.string(from: date)
                    let V2 = arrayInputString
                    dual.append((V1, V2))
                    print("- 뽑힌 시간은: \(V1), 뽑힌 이름은: \(V2)입니다.")
                    totalCountNum += 1
                    
                }
            } else {
                print("dismatch String")
            }
            
        }
        if result == userInput {
            print("총 이름 누적 갯수는: \(totalCountNum)")
            
            for(V1,V2) in pick1Array{
                print("- 뽑힌 시간은: \(V1), 뽑힌 이름은: \(V2)입니다.")
            }
            print("=========================================")
            for (times,name) in dual {
                print("- 뽑힌 시간은: \(times), 뽑힌 이름은: \(name)입니다.")
                
            }
        }
    }
}


var count = 1

func getRandomName(userInput: String) -> (Date,String){
    var resultName: String = ""
    
    //url객체생성
    guard let url = URL(string: "https://www.rivestsoft.com/nickname/getRandomNickname.ajax") else {
        fatalError("error")
    }
    var request = URLRequest(url:url)
    //let session = URLSession.shared //기본 세션<<
    //아래의 3가지 조건이 필요한경우 addValue를 사용하여 필요한 네트워크 요청을 수행한다.
//    "Authorization": API 호출 시 인증 토큰을 포함합니다.
//    "Content-Type": HTTP 요청의 본문이 JSON 형식임을 지정합니다.
//    "User-Agent": 클라이언트 앱의 정보를 포함하여 서버에 전송합니다.
    
    //    var request = URLRequest(url: URL(string: "https://www.rivestsoft.com/nickname/getRandomNickname.ajax")!,timeoutInterval: Double.infinity)
    //request.addValue("JSESSIONID=8A2490A97FC62B25008FB376DFE395B9", forHTTPHeaderField: "Cookie")
    //request.addValue("Value/*쿠키값*/", forHTTPHeaderField: "HeaderField/*헤더필드*/") 원문
    //HTTP메서드 설정
    request.httpMethod = "POST"
    //DispatchSemaphore 여러 실행 컨테스트에서 리소스에 대한 엑세서를 제어하는 개체
    let semaphore = DispatchSemaphore(value: 0)//비동기 작업이 완료되기전에 꺼짐
    
    //url 요청을 기반으로 컨텐츠를 검색하고 완료시 핸들러를 호출
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        defer { semaphore.signal() } //defer로 함수 종료 직전에 꼭 호출됨 세마포어로 signal을 wait에게 보냄
        guard let data = data else {
            print(String(describing: error))
            return
        }
        do {
            let jsonFile = try JSONDecoder().decode(jsonFile.self, from: data)
            //print("[뽑은 닉네임] : \(jsonFile.data), 순서: \(count)")
            resultName = jsonFile.data
            count += 1
            
        }
        catch {
            print("JSONSerialization error:", error)
        }
    }
    
    task.resume()
    semaphore.wait() //비동기 작업이 끝날때 까지 대기
    return (date,resultName)
}

main()

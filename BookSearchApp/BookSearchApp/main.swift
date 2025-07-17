//
//  main.swift
//  BookSearchApp
//
//  Created by 윤주형 on 7/17/24.
//

import Foundation

let myApiKey = "f80a80c44f07dbdb1050a27b0b7f9999"
var page: Int = 1
let exit = "exit"
var runningLoop: Bool = true
let checkRecordList: Bool = true
let turnAPage:Bool = true
var pageController: Bool = true
let secrectKey = "1234"

//구조체는 첫번쨰부터 댑문자
struct Document: Decodable {
    let title: String
    let authors: [String]
    
}
//data를 가지고 있는 최상위 요소가 documents란 배열이여서 얘를 불러줘야함
struct ApiResponse: Decodable {
    let documents: [Document]
    
    
}
struct Meta: Decodable {
    var is_end: Bool = false
    var total_count = 50
}

fileprivate func searchingBookFunc(searchObject: String, putPage: Int) {
    
    var request = URLRequest(url: URL(string: "https://dapi.kakao.com/v3/search/book?query=\(searchObject)&page=\(putPage)&size=10")!,timeoutInterval: Double.infinity)
    request.addValue("KakaoAK \(myApiKey)", forHTTPHeaderField: "Authorization")
    
    request.httpMethod = "GET"
    
    let semaphore = DispatchSemaphore(value: 0)
    
    let task = URLSession.shared.dataTask(with: request) { data, reponse, error in
        defer {semaphore.signal()}
        guard let data = data else {
            print(String(describing: error))
            return
        }
        
        do {
            let ApiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
            
            //가져온 data가 몇개인지 확인 == 배열 갯수가 책 갯수
            let findBookCount = ApiResponse.documents.count
            if findBookCount == 0 {
                print("찾으시는 도서가 없습니다.")
            }
            
            //배열이기때문에 index로 접근하거나
            for document in ApiResponse.documents {
                
                //저자 2인 이상일때 누구 외 몇명 적용 if문
                if document.authors.count > 1 {
                    let authorCount = document.authors.count - 1
                    print("{ 책 제목: \(document.title), 저자: \(document.authors.first!) 외 \(authorCount)인 },")
                } else {
                    print("{ 책 제목: \(document.title), 저자: \(document.authors) },")
                }
            }
            print("찾은 도서수\(findBookCount)권,")
            //결과 페이지 번호, 1~50 사이의 값, 기본 값 1 // 왜 Meta()인지 모르겠음 이거 api로 데이터를 받아온게 아닌 내가 직접 만든 구조체라서그럼
            print("\n현재 페이지 :\(page) / 총 페이지 \(Meta().total_count)")
        }
        catch {
            print("JSONSerialization error:", error)
        }
        
    }
    task.resume()
    semaphore.wait()
}

var bookNameArray: [String] = []
func main() {
    
    
    while runningLoop {
        print("[도서검색: search], [검색어 기록 확인: record], [종료: exit]")
        let userinput = readLine()
        
        switch true {
        case userinput == exit:
            runningLoop = false
            
            
        case userinput == "search": do {
            print("검색하실 책 제목을 입력해주세요")
            if let bookName = readLine() , !bookName.isEmpty {
                /*user가 검색한 기록을 앱 데이터 박스에 저장함
                 저장을 배열로 해야지 반복문으로 뽑아냄
                 
                 bookNameArray.append(bookName ?? "not append")
                 저장은하는데 append한 배열을 통쨰로 올려버려서 초기화 되어버림
                 array로 넣어줘야한다.
                 bookNameArray.append(bookName ?? "String") //["a","b"]
                 
                 빈 배열 만듦
                 let savedArray = UserDefaults.standard.array(forKey: "1234") as? [String]
                 var newArray = savedArray
                 newArray?.append(bookName)
                 */
                
                /* 추가 미션
                 페이징 처리
                 도서 검색 api 호출시 - 페이지 정보를 노출시켜준다
                 예) 현재 페이지 / 총 페이지
                 다음 페이지로 넘기시겠습니까? true 시 //다음페이지가 있는지 없는지 확인하고 넘기기 logic meta { is_end != false -> goNextPage}
                 현재 페이지에서 다음페이지로 검색 결과를 보여준다
                 
                 사용자 도서 검색 ->
                 검색 결과 + 페이지 정보 노출
                 
                 사용자 메뉴 예시)
                 [다음 페이지로 넘기기 next] [이전 페이지로 돌아가기 prev] [처음 페이지로 돌아가기 first] [메뉴로 돌아가기 menu]
                 */
                searchingBookFunc(searchObject:bookName, putPage: page)
                
                //타입 캐스팅 + var로 복사해서 쓰는 이유는 UserDefaults 객체가 불변일수도있어서
                var bookArray: [String] = UserDefaults.standard.array(forKey: secrectKey) as? [String] ?? ["nil"]
                //                var newArray = oka
                /*이제 보니 UserDefaults.standard.set(oka, forKey: "1234") 이거 func void 타입이네*/
                // 배열을 다시 UserDefaults에 저장 지금 배열상태
                
                if bookArray.contains(bookName) {
                    let findSameString =  bookArray.firstIndex(of: bookName)
                    print("replace to array index end \(bookName)*")
                    bookArray.remove(at: findSameString ?? -1)
                }
                bookArray.append(bookName)
                UserDefaults.standard.set(bookArray, forKey: "secrectKey")
                
                pageController = true
                while pageController {
                    print("[다음 페이지로 넘기기 next] [이전 페이지로 돌아가기 prev] [처음 페이지로 돌아가기 first] [메뉴로 돌아가기 menu]")
                    let selectFigureMethod = readLine()
                    
                    switch true {
                    case selectFigureMethod == "next": do {
                        page += 1
                        if page <= Meta().total_count {
                            searchingBookFunc(searchObject:bookName, putPage: page)
                        }
                    }
                    case selectFigureMethod == "prev": do {
                        page -= 1
                        if page < 1 {
                            page = 1
                            searchingBookFunc(searchObject:bookName, putPage: page)
                            print("가장 첫번째 페이지 입니다.")
                        } else {
                            searchingBookFunc(searchObject:bookName, putPage: page)
                        }
                    }
                        
                    case selectFigureMethod == "first": do {
                        page = 1
                        searchingBookFunc(searchObject:bookName, putPage: page)
                        print("첫번째 페이지로 돌아갑니다.")
                    }
                    case selectFigureMethod == "menu": do {
                        print("메뉴로 돌아갑니다")
                        pageController = false
                    }
                    default:
                        print("선택지가 제대로 선택되지 않았습니다.")
                    }
                }
            }
        }
            
        case userinput == "record": do {
            let moveToMenu: String = "1"
            let removeAllResearch: String = "2"
            let removeSpecificResearch: String = "3"
            
            //let savedData = UserDefaults.standard.object(forKey: "1234") as? [String]
            //object 여도 상관없음 대신 타입 캐스팅 해야됨
            print("============검색했던 기록입니다.============")
            if let savedData = UserDefaults.standard.array(forKey: "secrectKey") {
                
                for index in 1..<savedData.count{
                    print("\(index). \(savedData[index])")
                }
            }
            
            //UserDefaults.standard.removeObject(forKey: "1234")
            while checkRecordList {
                print("\n1.[메뉴로 이동], 2.[검색어 전체 삭제], 3.[검색어 삭제]")
                let selectRecordList = readLine()
                
                if selectRecordList == moveToMenu {
                    print("메뉴로 이동합니다")
                    break
                }
                
                if selectRecordList == removeAllResearch {
                    UserDefaults.standard.removeObject(forKey: "secrectKey")
                    print("검색어 전체 삭제 완료")
                }
                //Data 값 유형을 사용하면 간단한 바이트 버퍼가 Foundation 객체의 동작을 수행할 수 있습니다. 다양한 소스에서 비어 있거나 미리 채워진 버퍼를 생성하고 나중에 바이트를 추가하거나 제거할 수 있습니다. 콘텐츠를 필터링 및 정렬하거나 다른 버퍼와 비교할 수 있습니다. 바이트의 하위 범위를 조작하고 그 중 일부 또는 전부를 반복할 수 있습니다.
                if selectRecordList == removeSpecificResearch {
                    
                    if var savedData = UserDefaults.standard.array(forKey: "secrectKey") as? [String] {
                        print("삭제할 번호를 입력해주세요")
                        let deleteNum = readLine()
                        
                        if let removeIndexNum = Int(deleteNum ?? ""), removeIndexNum > 0 && removeIndexNum < savedData.count {
                            savedData.remove(at: removeIndexNum)
                            
                            // 변경된 배열을 다시 저장
                            UserDefaults.standard.set(savedData, forKey: "secrectKey")
                            print("수정된 기록입니다.")
                            for index in 1...savedData.count - 1 {
                                print("\(index). \(savedData[index])")
                            }
                            UserDefaults.standard.set(savedData, forKey: "secrectKey")
                            
                        }else {
                            print(#fileID, #function, #line, "removeIndexNum out of range")
                        }
                    } else {
                        print("정확한 번호를 입력해주세요")
                    }
                }
            }
        }
        default:
            print("정확한 키워드를 입력해주세요.")
        }
    }
}

main()

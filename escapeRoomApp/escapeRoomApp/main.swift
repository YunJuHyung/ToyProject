//
//  main.swift
//  escapeRoomApp
//
//  Created by 윤주형 on 8/1/24.
//

import Foundation


var dungeon: Bool = true
//타이머 struct로 만들수도있음

public class CharacterInfo {
    static let shared = CharacterInfo()
    
    var playerName: String
    var playerHP: Int
    var stageClear: Int
    
    init(playerName: String = "", playerHP: Int = 100, stageClear: Int = 0) {
        self.playerName = playerName
        self.playerHP = min(playerHP, 100)
        self.stageClear = stageClear
    }
}

public class Info: CharacterInfo {
    static let itemShared = Info()
    
    var characterInfo: CharacterInfo
    var playerItemLifeKit: Int
    var playerItemQuizHint: Int
    
    private init(playerItemLifeKit: Int = 3, playerItemQuizHint: Int = 2) {
        self.playerItemLifeKit = playerItemLifeKit
        self.playerItemQuizHint = playerItemQuizHint
        self.characterInfo = CharacterInfo.shared
    }
}


//플레이어 입장
func main() {
    let player = CharacterInfo.shared
    print("플레이어의 이름을 입력해주세요")
    let userInput = String(readLine() ?? "")
    
    print("안녕하세요 \(userInput)님 던전에 오신것을 환영합니다.")
    print("텍스트 명령어를 통해 문제를 풀고 탈출하시면 됩니다.")
    print("exit로 언제든지 종료가능합니다.아이템 사용은 useItem을 입력하시면됩니다.")
    print("사용가능한 아이템은 (use Lifekit) 3개와 (use Hint) 2개가 있습니다.")
    print("[주의 사항] 제한 시간은 180초 이며 30초마다 \(userInput)의 체력은 10씩 깍이게됩니다.")
    //플레이어 이름 저장
    player.playerName = userInput
    let okok = Game()
    
    okok.lifeDecreaseEvery30second()
    okok.startTimer()
    while dungeon {
        quizForPlayer()
        sleep(1)
        
    }
    
    
}

///Userdefaults에 딕셔너리 형태로 플레이어 저장해야됨
//플레이어 저장 로직

// 플레이어가 회복 아이템과 힌트 아이템을 사용 로직
public func useItem(itemNumber: String) {
    let playerItem = Info.itemShared
    let characterInfo = CharacterInfo.shared
    
    
    switch itemNumber {
    case "1" :
        playerItem.playerItemLifeKit -= 1
        /* 최대값을 고정하는 방법: min(x,y) x(T)랑 y(T)랑 비교해서 -> min T*/
        characterInfo.playerHP = min(characterInfo.playerHP + 30, 100)
        print("남은 힐킷은\(playerItem.playerItemLifeKit)개 입니다.\n현재 체력은 \(characterInfo.playerHP)입니다.")
        
    case "2" :
        playerItem.playerItemQuizHint -= 1
        let findQuizIndex = characterInfo.stageClear
        switch findQuizIndex {
        case 0:
            print("힌트는 20")
        case 1:
            print("힌트는 18")
        case 2:
            print("힌트는 9")
        case 3:
            print("힌트는 100")
        case 4:
            print("힌트는 0")
        default:
            print("index범위 오류")
        }
    default:
        print("아무 아이템도 사용되지 않았습니다.")
    }
}



//플레이어가 풀어야할 문제 로직
struct QuizQuestion {
    let question: String
    let answer: String
}

class Quiz {
    //퀴즈가 들어있는 배열을 만들어서 여기에 퀴즈를 넣고 퀴즈의 갯수보다 넘어가지 않게 if문으로 확인한다음
    //퀴즈를 푼다.
    //퀴즈배열에서 퀴즈퀘스쳔 구조체를 쓰지깐 타입이 퀴즈퀘스쳔이다
    var quizArray: [QuizQuestion] = []
    var currentIndex: Int = 0
    
    
    //퀴즈배열에 퀴즈 넣기
    init() {
        self.inputQuiz()
    }
    
    
    private func inputQuiz() {
        quizArray.append(QuizQuestion(question: "문제입니다: 10 + 10 = ?", answer: "20"))
        quizArray.append(QuizQuestion(question: "문제입니다: 20 - 2 = ?", answer: "18"))
        quizArray.append(QuizQuestion(question: "문제입니다: 3 * 3 = ?", answer: "9"))
        quizArray.append(QuizQuestion(question: "문제입니다: 400 / 4 = ?", answer: "100"))
        quizArray.append(QuizQuestion(question: "문제입니다: 55 % 5 = ?", answer: "0"))
    }
    
    func nextQuestion() -> QuizQuestion? {
        if currentIndex < quizArray.count {
            let currentQuiz = quizArray[currentIndex]
            currentIndex += 1
            return currentQuiz
        } else {
            print("탈출 성공")
            dungeon = false

            saveUser()
            return nil
        }
    }
    
    func getCurrentIndex() -> Int {
        return currentIndex
       }
    
}

public func quizForPlayer() {
    let characterInfo = CharacterInfo.shared
    let quiz = Quiz()

        while let level = quiz.nextQuestion() {
            //상수 바인딩 개념 저장된 index를 알고있어서 그 값을 참조
            
            print("\(level.question)")
            let userInputAnswer = readLine()
            
            switch userInputAnswer {
                
            case "exit" :
                    saveUser()
                    break
                
            case level.answer :
                print("정답입니다 다음 방으로 이동합니다. 보너스로 HP를 10만큼 회복합니다.")
                characterInfo.playerHP = min(characterInfo.playerHP + 10, 100)
                characterInfo.stageClear += 1
                
            case "useItem" :
                print("1. 치료상자 사용, 2. 힌트사용")
                let userNumInput = String(readLine() ?? "")
                switch userNumInput {
                case "1":
                    useItem(itemNumber: userNumInput)
                    //if문도 사용해봤고 switch도 사용해봤지만 힌트사용후에 오답입니다를 출력하는 문제떄문에
                    //그냥 quiz의 index를 -1해줬음
                    quiz.currentIndex -= 1
                case "2" :
                    
                    useItem(itemNumber: userNumInput)
                    //if문도 사용해봤고 switch도 사용해봤지만 힌트사용후에 오답입니다를 출력하는 문제떄문에
                    //그냥 quiz의 index를 -1해줬음
                    quiz.currentIndex -= 1
                    
                default:
                        quiz.currentIndex -= 1
                        print("잘못된 입력입니다.")
                    
                }
            default :
                quiz.currentIndex -= 1
                print("오답입니다. 문제를 다시 참고해주세요.")
            }
    }
}


//MARK: 타이머 로직
//플레이어의 hp가 30초마다 10씩 깍이는 로직

public class Game {
    static let timeSingletone = Game()
    var timerCount = 179
    var lifetimeCount = 30
    
    public func lifeDecreaseEvery30second() {
        
        let player = CharacterInfo.shared
        
        
        DispatchQueue.global(qos: .background).async {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                self.lifetimeCount -= 1
                //print(self.lifetimeCount)
                
                if self.lifetimeCount == 0 {
                    self.lifetimeCount = 30
                }
                
                if self.timerCount % 30 == 0 {
                    
                    player.playerHP -= 10
                    print("30초 경과로 hp가 10깍입니다.")
                    
                }
                if player.playerHP <= -1 {
                    print("플레이어가 사망했습니다")
                    timer.invalidate()
                    dungeon = false
                    print("저장할 이름(forKey:)를 입력해주세요:")
                    
                        saveUser()
                    
                }
            }
            RunLoop.current.run()
        }
    }
    
    
    public func startTimer() {
        DispatchQueue.global(qos: .background).async {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                //print("\(self.timerCount)")
                self.timerCount -= 1
                
                if self.timerCount == -1 {
                    print("dungeon timer is over")
                    dungeon = false
                    
                    timer.invalidate()
                    print("저장할 이름(forKey:)를 입력해주세요:")
                    
                        saveUser()
                }
            }
            RunLoop.current.run()
        }
        
    }
    
}



public func saveUser() {
    let player = CharacterInfo.shared
    //dictionary는 [String: any] 형태로 저장이 되어야함
    
    let playerInfo: [String: Any] = ["name": player.playerName, "hp": player.playerHP
                                     , "StageClear" : player.stageClear]
    UserDefaults.standard.set(playerInfo, forKey: "\(player.playerName)")
    
    
    // 저장된 정보 출력
    if let updatedPlayerInfo = UserDefaults.standard.dictionary(forKey: player.playerName) {
        print("저장된 내용입니다 :\(updatedPlayerInfo)")
        
    }
    sleep(1)
    exit(0)
    
}


main()

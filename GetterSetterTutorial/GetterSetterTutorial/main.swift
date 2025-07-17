//
//  main.swift
//  GetterSetterTutorial
//
//  Created by Jeff Jeong on 8/18/24.
//

import Foundation

print("Hello, World!")

// 공식문서
// Getter, Setter

// - 원리 이해
// - 활용
// 1. 이름이 동일한 변수가 있을 경우
// 2. 다른 녀석을 건드리고 싶을 때

// 색깔 -> UI콤포넌트 배경색 바뀜 // setter
// 채팅방 정보 -> [방인원[], 메세지들[], 안읽은 메세지들[]] // getter

// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Computed-Properties

class Cat 
    
    var firstName : String = ""
    var lastName : String = ""
    
    var fullname: String {
        get {
            return "\(lastName) \(firstName)"
        }
    }
    
    var roomNumber : Int = 0
    var roomInfo: String = ""
    
    var keyNumber : Int {
        get {
            return 0
        }
        
        set(newKeyNumber) {
            self.roomNumber = newKeyNumber * 10
            self.roomInfo = "해당 방번호: \(self.roomNumber), 키번호: \(newKeyNumber)"
        }
    }
    
    // getter
    private (set) var name: String = ""
    
    // modify
    private var _name: String {
        get {
            return name
        }
        set(newName) {

            if newName.isEmpty {
                self.name = "이름없음"
                return
            }
            
            self.name = newName
        }
    }
    
    func changeName(newName: String){
        _name = newName
    }
    
}

let someCat = Cat()

//someCat.changeName(newName: "홀롤롤로")

//print("someCat.name: \(someCat.name)")

dump(someCat.roomNumber)
dump(someCat.roomInfo)

someCat.keyNumber = 10

dump(someCat.roomNumber)
dump(someCat.roomInfo)

class Dog {
    
    var name: String = "이름없음"
    var age: Int = 1
    
    var nicknameInfo: String = ""
    
    var nickname: String {
        get {
            return ""
        }
        set {
            print(#fileID, #function, #line, "- ")
            nicknameInfo = "닉네임: \(newValue)"
        }
    }
    
    // .info
    var info: String {
        get {
            return "name: \(self.name), age: \(self.age)"
        }
    }
}
//
//let someDog = Dog()
//
//let infoValue = someDog.info
//
//dump(someDog.nickname)
//
//someDog.nickname = "홀롤롤로"
//
//dump(someDog.nicknameInfo)
//
//dump(infoValue)

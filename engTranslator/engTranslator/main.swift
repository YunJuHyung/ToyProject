
import Foundation

let cho:[String] = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]

let jung:[String] = ["ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ","ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"]

let jong:[String] = [" ", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ","ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]

func main() {
    
    
    let engToKor: [Character: String] = [
        "r": "ㄱ", "R": "ㄲ", "s": "ㄴ", "e": "ㄷ", "E": "ㄸ", "f": "ㄹ", "a": "ㅁ", "q": "ㅂ", "Q": "ㅃ", "t": "ㅅ",
        "T": "ㅆ", "d": "ㅇ", "w": "ㅈ", "W": "ㅉ", "c": "ㅊ", "z": "ㅋ", "x": "ㅌ", "v": "ㅍ", "g": "ㅎ", "k": "ㅏ",
        "o": "ㅐ", "i": "ㅑ", "O": "ㅒ", "j": "ㅓ", "p": "ㅔ", "u": "ㅕ", "P": "ㅖ", "h": "ㅗ", "y": "ㅛ", "n": "ㅜ",
        "b": "ㅠ", "m": "ㅡ", "l": "ㅣ", " ": " "
    ]
    

    let userInput = String(readLine() ?? "")

    // 한글로 변환
    var koreanString: String = ""

    for char in userInput {
        if let korChar = engToKor[char] {
            koreanString.append(korChar)
        } else {
            koreanString.append(char)
        }
    }

    let unicode32 = userInput.unicodeScalars.map{$0.value}
    let unicode8 = Array(userInput.utf8) //다양한 방식이 있는데 한글은 3비트로 utf-8에 집중되어있다

    // 한글 문자열을 이차원배열로 변환
    var Array2Dimension: [[String]] = []
    var emptyArray: [String] = []

    for char in koreanString {
        emptyArray.append(String(char))
        if emptyArray.count == 3 {
            Array2Dimension.append(emptyArray)
            emptyArray = []
        }
    }

    
    if !emptyArray.isEmpty {
        Array2Dimension.append(emptyArray)
    }

    print("한글로 변환된 문자열:", koreanString)
    print("이차원 배열:", Array2Dimension)
    
    
    var finalString: String = ""
    for row in Array2Dimension {
        if row.count == 3 {
            let c1 = row[0]  // 초성
            let c2 = row[1]  // 중성
            let c3 = row[2]  // 종성
            
            if let koreanChar = hangle(c1: c1, c2: c2, c3: c3) {
                finalString.append(koreanChar)
            }
        }
    }

    print("변환된 한글 문자열:", finalString)
    
    
    func hangle(c1:String,c2:String,c3:String) -> Character? {
       
        guard let cho_i = cho.firstIndex(of: c1),
                 let jung_i = jung.firstIndex(of: c2),
                 let jong_i = jong.firstIndex(of: c3) else {
               return nil
           }
        

        let uniValue:Int = (cho_i * 21 * 28) + (jung_i * 28) + (jong_i) + 0xAC00;
        if let uni = Unicode.Scalar(uniValue) {
            return Character(uni)
        }

        return nil
    }
    //구성된 2차원 배열을 반복문으로 돌다가 [i]번째 배열의[1](3개중의 중간)인덱스가 모음이 아니면 [i - 1][2]는 " "비어있는 종성이고 그 위치부터 반복문을 다시 돌린다? 이건 구성이 너무빡세 로직이라기엔
    

    
}


main()

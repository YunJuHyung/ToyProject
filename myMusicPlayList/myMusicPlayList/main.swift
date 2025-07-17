//
//  main.swift
//  myMusicPlayList
//
//  Created by 윤주형 on 8/7/24.
//

import Foundation
import AVFoundation

//AddInstanceForFactory: No factory registered for id <CFUUID 0x6000030f4000> F8BB1C28-BAE8-11D6-9C31-00039315CD46  스캠 설정에서 환경 변수 만들어주면 없어짐 신경안써도되는 주의코드

fileprivate func findJanreList(_ userInput: String?, _ showSongList: (String) -> ()) -> String{
    switch userInput {
    case "1":
        let fileName: String = "Kpop"
        showSongList(fileName)
        return fileName
    case "2":
        let fileName: String = "Jpop"
        showSongList(fileName)
        return fileName
    case "3":
        let fileName: String = "Pop"
        showSongList(fileName)
        return fileName
    default :
        print("등록되지 않은 번호")
        return "number out of range"
    }
}

fileprivate func findJanreListArray(_ userInput: String?, _ showSongListReturnArray: (String) -> [String]) -> ([String], String) {
    switch userInput {
    case "1":
        let fileName: String = "Kpop"
        return (showSongListReturnArray(fileName), fileName)
    case "2":
        let fileName: String = "Jpop"
        return (showSongListReturnArray(fileName), fileName)
    case "3":
        let fileName: String = "Pop"
        return (showSongListReturnArray(fileName), fileName)
    default :
        print("등록되지 않은 번호")
        return (["nil"], "number out of range")
    }
}

public class SongPlayer {
    static let shared = SongPlayer()
    
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    var avQueuePlayer22 = AVQueuePlayer()
    var songJanre: String = ""
    
    func playSoundOnce(songName: String, songJanre: String) {
        //let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global(qos: .default).async {
            
            let path = "/Users/juhyoon/Desktop/UdemyProject/pparkCoding/myMusicPlayList/myMusicPlayList/Sounds/\(songJanre)/\(songName).mp3"
            let url = URL(fileURLWithPath: path)
            print("File URL Path: \(url.path)")
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                self.audioPlayer.numberOfLoops = 0
                self.audioPlayer.prepareToPlay()
                self.audioPlayer.play()
            } catch {
                print(error)
            }
        }
        RunLoop.current.run()
    }
    
    func playSoundEnternal(songName: String, songJanre: String) {
        //let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global(qos: .default).async {
            
            print("1")
            let path = "/Users/juhyoon/Desktop/UdemyProject/pparkCoding/myMusicPlayList/myMusicPlayList/Sounds/\(songJanre)/\(songName).mp3"
            let url = URL(fileURLWithPath: path)
            print("File URL Path: \(url.path)")
            do {
                print("2")
                self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                self.audioPlayer.numberOfLoops = -1 // index 랑 같은 느낌임
                self.audioPlayer.prepareToPlay()
                self.audioPlayer.play()
                
                //semaphore.signal()
                
            } catch {
                print(error)
            }
        }
        //semaphore.wait()
        RunLoop.current.run()
    }
    
    func playSoundAllEnternally(songJanreArray: [String], songJanre: String) {
        
        var playerItems: [AVPlayerItem] = []
        for (_, value) in songJanreArray.enumerated() {
            let path = "/Users/juhyoon/Desktop/UdemyProject/pparkCoding/myMusicPlayList/myMusicPlayList/Sounds/\(songJanre)/\(value)"
            let url = URL(fileURLWithPath: path)
            
            let asset = AVAsset(url: url)
            let playerItem = AVPlayerItem(asset: asset)
            
            playerItems.append(playerItem)
            print("File URL Path:\(url.path)")
        }
        
        self.avQueuePlayer22 = AVQueuePlayer(items: playerItems)
        print("\n\n append된 playerItem: \(playerItems)")
        
        DispatchQueue.global(qos: .default).async {
            self.avQueuePlayer22.play()
        }
        RunLoop.current.run()
    }
    
    func playSoundRandomly(songJanreArray: [String], songJanre: String) {
        //let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global(qos: .default).async {
            
            
            let selectedRandomElement = String(songJanreArray.randomElement() ?? "")
            print("1")
            let path = "/Users/juhyoon/Desktop/UdemyProject/pparkCoding/myMusicPlayList/myMusicPlayList/Sounds/\(songJanre)/\(selectedRandomElement)"
            let url = URL(fileURLWithPath: path)
            print("File URL Path: \(url.path)")
            do {
                print("2")
                self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                self.audioPlayer.numberOfLoops = 0
                self.audioPlayer.prepareToPlay()
                self.audioPlayer.play()
                
                //semaphore.signal()
                
            } catch {
                print(error)
            }
        }
        //semaphore.wait()
        RunLoop.current.run()
    }
}


func main() {
    
    func showSongList(directoryName: String) {
        let musicController = SongPlayer.shared
        musicController.songJanre = directoryName
        
        let soundsDirectory = "/Users/juhyoon/Desktop/UdemyProject/pparkCoding/myMusicPlayList/myMusicPlayList/Sounds/\(directoryName)"
        
        do {
            let fileManager = FileManager.default
            let files =  try fileManager.contentsOfDirectory(atPath: soundsDirectory)
            let mp3Files = files.filter { $0.hasSuffix(".mp3") }
            print("나 mp3만 있는 파일의 배열입니다: \(mp3Files)")
            
            // 파일 리스트 출력
            print("\(directoryName) 폴더의 mp3 파일 목록:")
            for file in mp3Files {
                print(file)
            }
            
        } catch {
            print("Kpop 폴더의 파일을 가져오는 데 실패했습니다: \(error)")
        }
    }
    
    func showSongListReturnArray(directoryName: String) -> [String]{
        let musicController = SongPlayer.shared
        musicController.songJanre = directoryName
        
        let soundsDirectory = "/Users/juhyoon/Desktop/UdemyProject/pparkCoding/myMusicPlayList/myMusicPlayList/Sounds/\(directoryName)"
        
        
        do {
            let fileManager = FileManager.default
            let files =  try fileManager.contentsOfDirectory(atPath: soundsDirectory)
            let mp3Files = files.filter { $0.hasSuffix(".mp3") }
            print("해당 mp3의 파일 리스트 배열입니다: \(mp3Files)")
            
            return mp3Files
            
        } catch {
            print("Kpop 폴더의 파일을 가져오는 데 실패했습니다: \(error)")
            return ["nil"]
        }
    }
    
    
    enum Songs {
        case Kpop(song: String)
        case Jpop(song: String)
        case Pop(song: String)
        
        func showJanre() -> String{
            switch self {
            case .Kpop(let song):
                return song
            case .Jpop(song: let song):
                return song
            case .Pop(song: let song):
                return song
            }
        }
    }
    
    //MARK: -- main문 실행
    print("나만의 노래 플레이리스트에 오신걸 환영합니다.")
    print("듣고싶은 장르를 선택해주세요.")
    print("1.[Kpop], 2.[Jpop], 3.[Pop]")
    
    let userInput = String(readLine() ?? "")
    var selectedJanre = ""
    var selectedJanreList = ([String](), "")
    var mainLoopRun: Bool = true
    let songPlayer = SongPlayer.shared
    
    while mainLoopRun {
        //한곡 재생할떄
        selectedJanre = findJanreList(userInput, showSongList(directoryName:))
        selectedJanreList = findJanreListArray(userInput, showSongListReturnArray(directoryName:))
        print("선택된 장르입니다: \(selectedJanre)")
        //모두재생, 무작위 재생할때
        let returnedSongArray: [String] = selectedJanreList.0
        print("확인용 === \(returnedSongArray),\(selectedJanreList.1)")
        
        print("메뉴: 1.[모두 재생 무한 반복], 2.[무작위 재생], 3.[한곡 1회 재생], 4.[한곡 무한 재생]")
        
        //func playSound..에서 semaphore을 사용했을 경우 switch문에서 스레드 제어가 안됨
        //그래서 runloop.current.run을 사용해야함
        let userInputPlayType = readLine()
        switch userInputPlayType {
        case "1":
            //[모두 재생 무한 반복]
            songPlayer.playSoundAllEnternally(songJanreArray: returnedSongArray, songJanre: selectedJanreList.1)
        case "2":
            //
            songPlayer.playSoundRandomly(songJanreArray: returnedSongArray, songJanre: selectedJanre)
        case "3":
            print("재생할 음악 ID를 입력해주세요")
            let userWishToPlay = String(readLine() ?? "")
            songPlayer.playSoundOnce(songName: userWishToPlay, songJanre: selectedJanre)
            mainLoopRun = false
        case "4":
            print("재생할 음악 ID를 입력해주세요")
            let userWishToPlay = String(readLine() ?? "")
            songPlayer.playSoundEnternal(songName: userWishToPlay, songJanre: selectedJanre)
            
        default:
            print("index 오류")
        }
    }// mainLoopRun while end Curly Brackets
}

main()

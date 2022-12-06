//: [Previous](@previous)

import Foundation

func getFileContent(fileName: String) -> String {
    var textFromFile = ""
    
    if let path = Bundle.main.path(forResource: fileName, ofType: "txt") {
        do {
            textFromFile = try String(contentsOfFile: path, encoding: .utf8)
        } catch {
            print("error from file reading: " + error.localizedDescription)
        }
    }
    
    return textFromFile;
}

func getFirstMarkerIndex(_ packet: String) -> Int? {
    
    if(packet.count < 14){
        return nil
    }
    
    var index = 1
    
    while index < packet.count {
        
        var fourLetterBuffer = ""
        
        // if index is still in the first 3 characters, set the start range to that start of the string
        var startRange = packet.index(packet.startIndex, offsetBy: 0)
        
        if index >= 13 {
            startRange = packet.index(packet.startIndex, offsetBy: index-13)
        }
        
        let endRange = packet.index(packet.startIndex, offsetBy: index)
        
        fourLetterBuffer = String(packet[startRange...endRange])
        
        // if current letter is not in the past 4 letters and the length of the length of the substring is 4, return the index
        if !doRepeatCharactersExist(fourLetterBuffer) && fourLetterBuffer.count == 14{
            return index+1;
        }
        
        index += 1
    }
    
    return nil
}

func doRepeatCharactersExist(_ input: String) -> Bool {
    
    for letter in input {
        
        let occurrences = input.components(separatedBy: String(letter)).count - 1
        
        if occurrences > 1 {
            return true;
        }
    }
    return false
}

func mainTaskDay6Part1(){
    
    let contentFromFile = getFileContent(fileName: "TuningTroubleInput")
    
    let lines = contentFromFile.components(separatedBy: .newlines)
    
    let packetString = lines[0]
    
    print(getFirstMarkerIndex(packetString) ?? "something went wrong returned nil")
        
}

mainTaskDay6Part1()

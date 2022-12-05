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

var priorityMap = [String: Int]()

func nextLetter(_ letter: String) -> String? {
    guard let uniCode = UnicodeScalar(letter) else {
        return nil;
    }
    
    switch uniCode {
    case "A"..<"Z","a"..<"z":
        return String(UnicodeScalar(uniCode.value + 1)!)
    default:
        return nil;
    }
}

func constructPriorityMap(){
    var lowerLetter = "a"
    var upperLetter = "A"
    var lowerLetterPriority = 1
    var upperLetterPriority = 27
    
    while !lowerLetter.isEmpty {
        
        priorityMap[lowerLetter] = lowerLetterPriority
        priorityMap[upperLetter] = upperLetterPriority
        
        lowerLetter = nextLetter(lowerLetter) ?? ""
        upperLetter = nextLetter(upperLetter) ?? ""
        
        lowerLetterPriority += 1
        upperLetterPriority += 1
    }
}

func findTotalPriorityPart1(_ lines: [String]) -> [String] {
    
    var commonTypes = [String]()
    
    // sort letters into two parts
    for line in lines {
        
        if line.isEmpty {
            continue;
        }
        
        let length = line.count
        
        if !(length%2 == 0){
            continue;
        }
        
        let firstHalf = line.prefix(length/2)
        let secondHalf = line.suffix(length/2)
        
        for letter in secondHalf {
            if firstHalf.contains(letter) {
                commonTypes.append(String(letter))
                break;
            }
        }
    }
    
    return commonTypes
}

func findTypesPart2(_ lines: [String]) -> [String]{
    var commonTypes = [String]()
    
    var elfIndex = 0
    
    while elfIndex < lines.count {
       
        if lines[elfIndex].isEmpty {
            break;
        }
        
        let firstElf = lines[elfIndex]
        let secondElf = lines[elfIndex+1]
        let thirdElf = lines[elfIndex+2]
        
        var commonLetters = [String]()
        
        for letter in firstElf {
            if secondElf.contains(letter) {
                commonLetters.append(String(letter))
            }
        }
        
        for letter in commonLetters {
            if thirdElf.contains(letter) {
                commonTypes.append(letter)
                break;
            }
        }
        
        elfIndex += 3
    }
    
    return commonTypes;
}

func mainTaskDay3(){
    constructPriorityMap();
    
    // get input from file
    let contentFromFile = getFileContent(fileName: "ItemTypeInput")
    
    // create array of input
    var lines = contentFromFile.components(separatedBy: .newlines)
    // part 1
//    var commonTypes = findTotalPriorityPart1(lines)
    
    // part 2
    var commonTypes = findTypesPart2(lines)
    
    print(commonTypes.count)
    print(commonTypes)
    
    var totalPriority = 0;
    
    for letter in commonTypes {
        totalPriority += priorityMap[letter] ?? 0
    }
    
    print(totalPriority)
}

mainTaskDay3();

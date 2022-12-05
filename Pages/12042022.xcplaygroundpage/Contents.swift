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

func isFullyInclusive(firstAssignment: [Int], secondAssignment: [Int]) -> Bool {
    
    let firstElfLower = Int(firstAssignment[0])
    let firstElfUpper = Int(firstAssignment[1])
    
    let secondElfLower = Int(secondAssignment[0])
    let secondtElfUpper = Int(secondAssignment[1])
    
    if firstElfLower <= secondElfLower && firstElfUpper >= secondtElfUpper {
        return true;
    } else if secondElfLower <= firstElfLower && secondtElfUpper >= firstElfUpper {
        return true;
    }
    
    return false;
}

func isOverlap(firstAssignment: [Int], secondAssignment: [Int]) -> Bool {
    
    let firstElfLower = Int(firstAssignment[0])
    let firstElfUpper = Int(firstAssignment[1])
    
    let secondElfLower = Int(secondAssignment[0])
    let secondtElfUpper = Int(secondAssignment[1])
    
    if secondElfLower <= firstElfUpper && secondElfLower >= firstElfLower {
        return true
    } else if firstElfLower <= secondtElfUpper && firstElfLower >= secondElfLower {
        return true
    } else if secondtElfUpper >= firstElfLower && secondtElfUpper <= firstElfUpper {
        return true
    } else if firstElfUpper >= secondElfLower && firstElfLower <= secondtElfUpper{
        return true
    }
    
    return false
}

func overlappingAssignments(_ lines: [String]) -> Int {
    var fullyInclusiveAssignments = 0;
    var overlappingAssignments = 0;
    
    for line in lines {
     
        if line.isEmpty {
            continue;
        }
        
        let assignments = line.split(separator: ",")
        
        let firstElf = assignments[0].split(separator: "-")
        let secondElf = assignments[1].split(separator: "-")
        
        let firstElfInt = [Int(firstElf[0]) ?? 0, Int(firstElf[1]) ?? 0]
        let secondElfInt = [Int(secondElf[0]) ?? 0, Int(secondElf[1]) ?? 0]
        
        if isFullyInclusive(firstAssignment: firstElfInt, secondAssignment: secondElfInt) {
            fullyInclusiveAssignments += 1
        }
        
        if isOverlap(firstAssignment: firstElfInt, secondAssignment: secondElfInt) {
            overlappingAssignments += 1
        }
    }
    
    return overlappingAssignments;
}

func mainTaskDay4Part1(){
    let contentFromFile = getFileContent(fileName: "CampCleanupInput")
    
    let lines = contentFromFile.components(separatedBy: .newlines)
    
    print(overlappingAssignments(lines))
}

mainTaskDay4Part1()

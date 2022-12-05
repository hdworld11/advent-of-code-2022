//: [Previous](@previous)

import Foundation

var stacks = [Int: [String]]()

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

func getStacks(_ lines: [String]) -> [Int: [String]] {
    
    var stacks = [Int: [String]]()
    
    for line in lines {
        if line.isEmpty{
            continue
        }
        
        var crateStack = 1
        var index = 0
        
        while index < line.count {
            
            let startIndex = line.index(line.startIndex, offsetBy: index)
            let endIndex = line.index(line.startIndex, offsetBy: index+3)
            
            var crate = String(line[startIndex..<endIndex])
            
            if !crate.isEmpty && !crate.contains(" ") {
                var stack = stacks[crateStack]
                
                if stack != nil {
                    stack?.append(crate)
                } else {
                    stack = [crate]
                }
                
                stacks[crateStack] = stack
            }
            
            crateStack += 1
            index += 4
        }
    }
    
    print(stacks)
    
    return stacks
}

func moveCratePart1(from: Int, to: Int) {
    //remove from one stack
    let crate = stacks[from]?.removeFirst()
    
    // add to new stack
    if let cratex = crate {
        stacks[to]?.insert(cratex, at: 0)
    }
}

func moveCratePart2(count: Int, from: Int, to: Int) {
    var cratesToMove = [String]()
    
    for _ in 1...count {
        cratesToMove.append(stacks[from]?.removeFirst() ?? "")
    }
    
    var existingCrates = stacks[to] ?? [String]()
    cratesToMove.append(contentsOf: existingCrates)
    stacks[to] = cratesToMove

}
    

func mainTastDay5(){
    
    let contentFromFile = getFileContent(fileName: "SupplyStacksInput")
    
    let lines = contentFromFile.components(separatedBy: .newlines)
    
    stacks = getStacks(lines)
    
    let instructions = getFileContent(fileName: "SupplyStackInstructions").components(separatedBy: .newlines)
    
    for instruction in instructions {
        
        if instruction.isEmpty{
            continue
        }
        
        var temp = instruction.components(separatedBy: CharacterSet.decimalDigits.inverted)
        var instructionData = [Int]()
        //cleanup
        for item in temp {
            if !item.isEmpty {
                instructionData.append(Int(item) ?? 0)
            }
        }
        
        print(instructionData)
        
        var count = instructionData[0]
        var from = instructionData[1]
        var to = instructionData[2]
        
//        for _ in 1...count {
//            moveCratePart1(from: from, to: to)
//        }
        
        moveCratePart2(count: count, from: from, to: to)
    }
    
    var topCrates = [String]()
    
    for i in 1...stacks.count {
        topCrates.append(stacks[i]?.removeFirst() ?? "")
    }
    
    print(topCrates)
}

mainTastDay5()

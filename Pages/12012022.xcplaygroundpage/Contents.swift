//: [Previous](@previous)

import Foundation

struct Elf {
    
    var foodItems: [Int] = []
    
    var totalCals: Int {
        get {
            var totalCals = 0;
            for val in foodItems {
                totalCals += val;
            }
            return totalCals;
        }
    }
}


func getElfs(elfsFile: String) -> [Elf] {
    
    let stringFromFile = getFileContent(fileName: elfsFile)
    
    let lines = stringFromFile.components(separatedBy: .newlines)
    
    var returnElfs: [Elf] = [];
    var elfIndex = 0;
    
    for i in 0..<lines.count {

        if !returnElfs.indices.contains(elfIndex) {
            returnElfs.append(Elf())
        }
        
        let line = lines[i];
        
        if line.isEmpty {
            elfIndex += 1;
            continue;
        } else {
            returnElfs[elfIndex].foodItems.append(Int(line) ?? 0)
        }
    }
    
    return returnElfs;
}

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

func ElfDay1Part1(){
    
    let allElfs = getElfs(elfsFile: "./Resources/ElfsTest")
    
    var mostCalsCarried = 0;
    
    for elf in allElfs {
        if elf.totalCals >  mostCalsCarried {
            mostCalsCarried = elf.totalCals
        }
    }
    print(mostCalsCarried);
}

func ElfDay1Part2(){
    let allElfs = getElfs(elfsFile: "./Resources/ElfsMain")
    
    let sortedElfs = allElfs.sorted(by: {$0.totalCals > $1.totalCals})
    
    print(sortedElfs[0].totalCals);
    print(sortedElfs[1].totalCals);
    print(sortedElfs[2].totalCals);
    
    let top3total = sortedElfs[0].totalCals + sortedElfs[1].totalCals + sortedElfs[2].totalCals
    
    print(top3total)
}

ElfDay1Part2();

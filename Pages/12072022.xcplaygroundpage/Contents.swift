//: [Previous](@previous)

import Foundation

let PART1_SIZE = 100000
let TOTAL_FILESIZE = 70000000 // 70,000,000
let UPDATE_SIZE = 30000000 // 30,000,000

struct File{
    let name: String
    let size: Int
}

class Directory {
    let name: String
    let parentDirectory: Directory?
    var files: [File]
    var directories: [Directory]
    
    init(name: String, parentDirectory: Directory?){
        self.name = name
        self.parentDirectory = parentDirectory
        files = [File]()
        directories = [Directory]()
    }
    
    var size: Int = 0
    
    func getDirectoryWith(name: String) -> Directory? {
        
        for directory in directories {
            if directory.name == name {
                return directory
            }
        }
        return nil;
    }
    
    func addFile(name: String, size: Int) {
        self.files.append(File(name: name, size: size))
    }
    
    func addDirectory(name: String, parentDirectory: Directory?){
        self.directories.append(Directory(name: name, parentDirectory: parentDirectory))
    }
}

var rootDirectory = Directory(name: "/", parentDirectory: nil)

var outputDirectories = [Directory]()

var directoryToBeDeleted = rootDirectory

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

func findSizes(fromDirectory: Directory) -> Int{
    
    var fileSizes = fileSizes(files: fromDirectory.files)
    
    var directorySize = 0
    
    for directory in fromDirectory.directories {
        directorySize += findSizes(fromDirectory: directory)
    }
    
    fromDirectory.size = directorySize + fileSizes
    
    if fromDirectory.size <= PART1_SIZE {
        outputDirectories.append(fromDirectory)
    }
    
    return fromDirectory.size
}

func fileSizes(files: [File]) -> Int {
    
    var totalSize = 0
    
    for file in files {
        totalSize += file.size
    }
    
    return totalSize
}

func processCommands(commands: [String]){
    var currentDirectory:Directory? = rootDirectory
    
    for line in commands {
        
        if line.isEmpty {
            continue
        }
        
        let lineParts = line.components(separatedBy: " ")
        
        if line.starts(with: "$") {
            
            // this is a command, "cd", "ls",
            
            var first = lineParts[1]
        
            if first == "cd" {
                
                var second = lineParts[2]
                
                if second == ".." {
                    // go up one
                    currentDirectory = currentDirectory?.parentDirectory
                    continue
                    
                } else if second == "/" {
                    continue
                }else {
                    // going into a new directory
                    if let nextDirectory = currentDirectory?.getDirectoryWith(name: second) {
                        currentDirectory = nextDirectory
                    } else {
                        print("cannot find sub directory with name: " + second)
                    }
                }
            } else if first == "ls" {
                // nothing to do here, continue to next line
                continue
            }
        }
        else if Int(lineParts[0]) != nil { // numbers {
            // this is a file
            
            let fileSize = Int(lineParts[0]) ?? 0
            let fileName = String(lineParts[1])
            
            currentDirectory?.addFile(name: fileName, size: fileSize)
        }
        else if line.starts(with: "dir") {
            // this is a directory
            
            var dirInfo = line.components(separatedBy: " ")
            var dirName = dirInfo[1]
            
            currentDirectory?.addDirectory(name: dirName, parentDirectory: currentDirectory)
        }
    }
}

func getDirectoryForSpace(_ spaceRequired: Int, startDirectory: Directory) {
    
    if startDirectory.size < spaceRequired {
        // the directory already has lower space, return because it doesn't make sense to go deeper
        return
    }
        
    for directory in startDirectory.directories {
        if directory.size >= spaceRequired && directory.size < directoryToBeDeleted.size{
            directoryToBeDeleted = directory
        }
        getDirectoryForSpace(spaceRequired, startDirectory: directory)
    }
    
    return
}

func mainTaskDay7(){
    
    let contentFromFile = getFileContent(fileName: "Day7Input")
    
    let lines = contentFromFile.components(separatedBy: .newlines)
    
    processCommands(commands: lines)
    
    rootDirectory.size = findSizes(fromDirectory: rootDirectory)
    
    var totalSize = 0
    
    for directory in outputDirectories {
        totalSize += directory.size
    }
    
    print(UPDATE_SIZE - (TOTAL_FILESIZE - rootDirectory.size))
    
    var spaceAvailable = TOTAL_FILESIZE - rootDirectory.size
     
    if spaceAvailable >= UPDATE_SIZE {
        // enough space exists to perform update
        return
    }
    
    var spaceRequired = UPDATE_SIZE - spaceAvailable
    
    getDirectoryForSpace(spaceRequired, startDirectory: rootDirectory)
    
    print(directoryToBeDeleted.size)
}

mainTaskDay7()

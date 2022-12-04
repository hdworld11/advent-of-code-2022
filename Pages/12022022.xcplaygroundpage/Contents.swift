import UIKit

// Rock = A, X, 1
// Paper = B, Y, 2
// Scissors = C, Z, 3

// X = lose
// Y = draw
// Z = win

let opponentArray = ["A","B","C"]
let myArray = ["X","Y","Z"]

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

func roundScorePart1(me: String, opponent: String) -> Int{
    
    var myScore = 0;
    
    // this is a draw
    if myArray.firstIndex(of: me) == opponentArray.firstIndex(of: opponent) {
        myScore += 3
    }
    // rock defeats scissors
    // scissors defeats paper
    // paper defeats rock
    else if (me == "X" && opponent == "C") ||
            (me == "Y" && opponent == "A") ||
            (me == "Z" && opponent == "B"){
        myScore += 6
    }
    
    if me == "X" {
        myScore += 1
    } else if me == "Y" {
        myScore += 2
    } else if me == "Z" {
        myScore += 3
    }
    
    return myScore
}

func mainTaskDay2Part1() {
    // get lines from file
    var contentFromFile = getFileContent(fileName: "RockPaperScissorsRounds")
    
    var rounds = contentFromFile.components(separatedBy: .newlines)
    
    var finalScore = 0;
    
    for round in rounds {
        
        var plays = round.components(separatedBy: " ")
        
        if plays.count != 2 {
            print("unexpected input: " + round);
            continue;
        }
        
        let opponent = plays[0]
        let me = plays[1]
        
        finalScore += roundScorePart1(me: me, opponent: opponent)
    }
    
    print(finalScore)
}

func mainTaskDay2Part2() {
    // get lines from file
    var contentFromFile = getFileContent(fileName: "RockPaperScissorsRounds")
    
    var rounds = contentFromFile.components(separatedBy: .newlines)
    
    var finalScore = 0;
    
    for round in rounds {
        
        var plays = round.components(separatedBy: " ")
        
        if plays.count != 2 {
            print("unexpected input: " + round);
            continue;
        }
        
        let opponent = plays[0]
        let strategy = plays[1]
        
        finalScore += roundScorePart2(strategy: strategy, opponent: opponent)
    }
    
    print(finalScore)
}

struct Play {
    var toLose: String;
    var toWin: String;
    var toDraw: String;
}

func getPlay(play: String) -> Play? {
    if(play == "A"){ // rock
        return Play(toLose: "C", toWin: "B", toDraw: "A");
    } else if play == "B" { // paper
        return Play(toLose: "A", toWin: "C", toDraw: "B");
    } else if play == "C" { // scissors
        return Play(toLose: "B", toWin: "A", toDraw: "C");
    }
    
    return nil;
}

func getScore(play: String) -> Int {
    if(play == "A"){ // rock
        return 1;
    } else if play == "B" { // paper
        return 2;
    } else if play == "C" { // scissors
        return 3;
    }
    return 0
}

func roundScorePart2(strategy: String, opponent: String) -> Int {
    
    var myScore = 0;
    let play = getPlay(play: opponent)
    
    // outcome of round
    if strategy == "X"{ // to lose
        myScore += 0
        myScore += getScore(play: play?.toLose ?? "")
    } else if strategy == "Y" { // to draw
        myScore += 3
        myScore += getScore(play: play?.toDraw ?? "")
    } else if strategy == "Z" { // to win
        myScore += 6
        myScore += getScore(play: play?.toWin ?? "")
    }
    
    
    return myScore;
}

mainTaskDay2Part2();

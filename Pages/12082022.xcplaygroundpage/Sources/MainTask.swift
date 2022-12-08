import Foundation

public func mainTastDay8(){
    let content = getFileContent(fileName: "Day8Input")
    
    let lines = content.components(separatedBy: .newlines)
    
    let grid = constructGrid(lines)
    
    let treesVisibileInside = findVisibleTrees(grid: grid)
    
    print(treesVisibileInside)
    
//    var exteriorTrees = (grid.count * 4) - 4
    
//    print(treesVisibileInside)
    
}


func findVisibleTrees(grid: [[Int]]) -> Int {
    
    var highestViewingScore = 0
    
    // only look at the inner grid
    for treeAtIndexRow in 1..<(grid.count-1) {
        
        for treeAtIndexCol in 1..<(grid[treeAtIndexRow].count-1) {
            
            let treeHeight = grid[treeAtIndexRow][treeAtIndexCol]
            
            var isUpVisible = 0
            var isDownVisible = 0
            var isLeftVisible = 0
            var isRightVisible = 0
            
            // look left
            for i in (0..<treeAtIndexCol).reversed() {
                isLeftVisible += 1
                if grid[treeAtIndexRow][i] >= treeHeight {
                    break
                }
            }
            
            // look right
            for i in treeAtIndexCol+1..<grid[treeAtIndexRow].count {
                isRightVisible += 1
                if grid[treeAtIndexRow][i] >= treeHeight {
                    break
                }
            }
            
            // look up
            for i in (0..<treeAtIndexRow).reversed() {
                isUpVisible += 1
                if grid[i][treeAtIndexCol] >= treeHeight{
                    break
                }
            }
            
            // look down
            for i in treeAtIndexRow+1..<grid.count {
                isDownVisible += 1
                if grid[i][treeAtIndexCol] >= treeHeight{
                    break
                }
            }
            
            let viewingScore = isUpVisible * isDownVisible * isLeftVisible * isRightVisible
            
            if viewingScore > highestViewingScore {
                highestViewingScore = viewingScore
            }
        }
    }
    
    return highestViewingScore
}

func constructGrid(_ lines: [String]) -> [[Int]]{
    
    var returnGrid = [[Int]]()
    var rowIndex = 0
    
    for line in lines {
        
        if line.isEmpty {
            continue
        }
        
        returnGrid.append([Int]())
        for char in line {
            let treeHeight = Int(String(char))
            returnGrid[rowIndex].append(treeHeight ?? 0)
        }
        rowIndex += 1
    }
    return returnGrid
}

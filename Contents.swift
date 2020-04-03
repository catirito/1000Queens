
struct Square {
    var queen = false
    var protectedByQueen = false
    var isAvailable:Bool {
        return !queen && !protectedByQueen
    }
}

func myPrint(board: [[Square]], showColumns:Bool = false) {
    var totalQueens = 0
    
    if showColumns {
        for (rowIndex, row) in board.enumerated() {
            var stringRow = ""
            for (colIndex, col) in row.enumerated() {
                stringRow = "\(stringRow)\(rowIndex)-\(colIndex)\(String(col.queen))|"
                if col.queen {
                    totalQueens += 1
                }
            }
            print(stringRow)
        }
    }else{
        for row in board {
            var stringRow = ""
            for col in row {
                stringRow = "\(stringRow)\(String(col.queen))|"
                if col.queen {
                    totalQueens += 1
                }
            }
            print(stringRow)
        }
    }
    
    print("Total of queens: \(totalQueens)")
}


//
Main()

func Main() {
    
    let boardSize = 100

    var board:[[Square]] = Array(repeating: Array(repeating: Square(queen: false, protectedByQueen: false) , count: boardSize), count: boardSize)
    
    for (rowIndex, row) in board.enumerated() {
        for (colIndex, _) in row.enumerated() where board[rowIndex][colIndex].isAvailable {
            addQueen(board: &board, row: rowIndex, col: colIndex)
        }
    }
    
    myPrint(board: board, showColumns: false)

}

func addQueen( board: inout [[Square]], row:Int, col:Int) {
    board[row][col].queen = true
    protectSquares(board: &board, row: row, col: col)
}

func protectSquares(board: inout [[Square]], row:Int, col:Int) {
    
    protectRows(board: &board, row: row)
    protectCols(board: &board, col: col)
    protectDiagonals(board: &board, row: row, col:col)
    
}

func protectRows(board: inout [[Square]], row:Int) {
    for (index, _) in board[row].enumerated() {
        board[row][index].protectedByQueen = true
    }
}

func protectCols(board: inout [[Square]], col:Int) {
    for row in 0..<board.count {
        board[row][col].protectedByQueen = true
    }
}
 
func protectDiagonals(board: inout [[Square]], row:Int, col:Int) {
    let objective = row + col
    
    for indexRow in 0..<board.count {
        for indexCol in 0..<board[indexRow].count {
            if  indexRow + indexCol == objective {
                board[indexRow][indexCol].protectedByQueen = true
            }else if indexRow - indexCol == 0 {
                board[indexRow][indexCol].protectedByQueen = true
            }
        }
    }
}

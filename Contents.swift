
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

let boardSize = 100

var board:[[Square]] = Array(repeating: Array(repeating: Square(queen: false, protectedByQueen: false) , count: boardSize), count: boardSize)

//
Main()

func Main() {
    
    for (rowIndex, row) in board.enumerated() {
        for (colIndex, _) in row.enumerated() where board[rowIndex][colIndex].isAvailable {
            addQueen(row: rowIndex, col: colIndex)
        }
    }
}

func addQueen(row:Int, col:Int) {
    board[row][col].queen = true
    protectSquares(row: row, col: col)
}

func protectSquares(row:Int, col:Int) {
    
    protectRows(row: row)
    protectCols(col: col)
    protectDiagonals(row: row, col:col)
    
}

func protectRows(row:Int) {
    for (index, _) in board[row].enumerated() {
        board[row][index].protectedByQueen = true
    }
}

func protectCols(col:Int) {
    for row in 0..<board.count {
        board[row][col].protectedByQueen = true
    }
}
 
func protectDiagonals(row:Int, col:Int) {
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


myPrint(board: board, showColumns: false)


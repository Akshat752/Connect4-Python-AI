import Foundation

func testEmptyBoard() {
    let board = Board.createBoard()
    assert(board.allSatisfy { row in row.allSatisfy { $0 == Board.EMPTY } }, "Test failed: The board should be empty.")
    print("Empty board test passed.")
}

func testDropPieces() {
    var board = Board.createBoard()
    if let row = Board.getNextOpenRow(board: board, col: 0) {
        Board.dropPiece(board: &board, row: row, col: 0, piece: Board.PLAYER_PIECE)
    }
    assert(board[0][0] == Board.PLAYER_PIECE, "Test failed: Player piece not placed correctly.")

    if let row = Board.getNextOpenRow(board: board, col: 2) {
        Board.dropPiece(board: &board, row: row, col: 2, piece: Board.AI_PIECE)
    }
    assert(board[0][2] == Board.AI_PIECE, "Test failed: AI piece not placed correctly.")
    print("Drop pieces test passed.")
}

func testHorizontalWin() {
    var board = Board.createBoard()
    for col in 0...3 {
        if let row = Board.getNextOpenRow(board: board, col: col) {
            Board.dropPiece(board: &board, row: row, col: col, piece: Board.PLAYER_PIECE)
        }
    }
    assert(Board.winningMove(board: board, piece: Board.PLAYER_PIECE), "Test failed: Horizontal win not detected.")
    print("Horizontal win test passed.")
}

func testVerticalWin() {
    var board = Board.createBoard()
    for row in 0...3 {
        Board.dropPiece(board: &board, row: row, col: 0, piece: Board.PLAYER_PIECE)
    }
    assert(Board.winningMove(board: board, piece: Board.PLAYER_PIECE), "Test failed: Vertical win not detected.")
    print("Vertical win test passed.")
}

func testPositiveDiagonalWin() {
    var board = Board.createBoard()
    for i in 0...3 {
        Board.dropPiece(board: &board, row: i, col: i, piece: Board.PLAYER_PIECE)
    }
    assert(Board.winningMove(board: board, piece: Board.PLAYER_PIECE), "Test failed: Positive diagonal win not detected.")
    print("Positive diagonal win test passed.")
}

func testNegativeDiagonalWin() {
    var board = Board.createBoard()
    for i in 0...3 {
        Board.dropPiece(board: &board, row: 3 - i, col: i, piece: Board.PLAYER_PIECE)
    }
    assert(Board.winningMove(board: board, piece: Board.PLAYER_PIECE), "Test failed: Negative diagonal win not detected.")
    print("Negative diagonal win test passed.")
}

func testAIMoveForWinning() {
    var board = Board.createBoard()
    Board.dropPiece(board: &board, row: 0, col: 2, piece: Board.AI_PIECE)
    Board.dropPiece(board: &board, row: 1, col: 2, piece: Board.AI_PIECE)
    Board.dropPiece(board: &board, row: 2, col: 2, piece: Board.AI_PIECE)

    let (bestMove, _) = Board.minimax(board: board, depth: 1, alpha: Int.min, beta: Int.max, maximizingPlayer: true)
    assert(bestMove == 2, "Test failed: AI did not choose the winning column.")
    print("AI move for winning test passed.")
}

// Run tests
testEmptyBoard()
testDropPieces()
testHorizontalWin()
testVerticalWin()
testPositiveDiagonalWin()
testNegativeDiagonalWin()
testAIMoveForWinning()

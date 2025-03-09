import 'dart:math';
import 'package:flutter/material.dart';

class WordSearch extends StatefulWidget {
  const WordSearch({super.key});

  @override
  _WordSearchState createState() => _WordSearchState();
}

class _WordSearchState extends State<WordSearch> {
  final int gridSize = 7;
  final List<String> words = ["ROBOT", "FIGHT", "CLUB", "DESIGN"];
  late List<List<String>> grid;
  late List<List<bool>> highlighted;
  String currentWord = "";
  final Random _random = Random();
  Set<String> foundWords = {};
  List<int>? selectionDirection;
  List<List<int>> selectionPath = [];

  @override
  void initState() {
    super.initState();
    _generateGrid();
  }

  void _generateGrid() {
    grid = List.generate(gridSize, (_) => List.generate(gridSize, (_) => '.', growable: false), growable: false);
    highlighted = List.generate(gridSize, (_) => List.generate(gridSize, (_) => false, growable: false), growable: false);
    _placeWords();
    _fillEmptySpaces();
  }

  void _placeWords() {
    for (var word in words) {
      bool placed = false;
      while (!placed) {
        int row = _random.nextInt(gridSize);
        int col = _random.nextInt(gridSize);
        List<int> direction = _getRandomDirection();

        if (_canPlaceWord(word, row, col, direction)) {
          for (int i = 0; i < word.length; i++) {
            grid[row + i * direction[0]][col + i * direction[1]] = word[i];
          }
          placed = true;
        }
      }
    }
  }

  bool _canPlaceWord(String word, int row, int col, List<int> direction) {
    for (int i = 0; i < word.length; i++) {
      int newRow = row + i * direction[0];
      int newCol = col + i * direction[1];

      if (newRow < 0 || newRow >= gridSize || newCol < 0 || newCol >= gridSize || 
          (grid[newRow][newCol] != '.' && grid[newRow][newCol] != word[i])) {
        return false;
      }
    }
    return true;
  }

  List<int> _getRandomDirection() {
    List<List<int>> directions = [
      [0, 1], [1, 0], [1, 1], [-1, -1], [-1, 1], [1, -1], [0, -1], [-1, 0]
    ];
    return directions[_random.nextInt(directions.length)];
  }

  void _fillEmptySpaces() {
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        if (grid[row][col] == '.') {
          grid[row][col] = String.fromCharCode(_random.nextInt(26) + 65);
        }
      }
    }
  }

  void _selectLetter(int row, int col) {
    if (highlighted[row][col]) return;

    setState(() {
      if (selectionPath.isEmpty) {
        selectionPath.add([row, col]);
        currentWord = grid[row][col];
        highlighted[row][col] = true;
      } else {
        if (selectionPath.length == 1) {
          int dRow = row - selectionPath[0][0];
          int dCol = col - selectionPath[0][1];

          if ([dRow, dCol].any((d) => d != 0)) {
            if (dRow == 0 || dCol == 0 || dRow.abs() == dCol.abs()) {
              selectionDirection = [dRow.sign, dCol.sign];
            } else {
              return;
            }
          }
        }

        if (selectionDirection != null) {
          int expectedRow = selectionPath.last[0] + selectionDirection![0];
          int expectedCol = selectionPath.last[1] + selectionDirection![1];

          if (row == expectedRow && col == expectedCol) {
            selectionPath.add([row, col]);
            currentWord += grid[row][col];
            highlighted[row][col] = true;

            if (words.contains(currentWord)) {
              foundWords.add(currentWord);
              _resetSelection();
            }
          }
        }
      }
    });
  }

  void _resetSelection() {
    setState(() {
      for (var pos in selectionPath) {
        highlighted[pos[0]][pos[1]] = false;
      }
      selectionPath.clear();
      selectionDirection = null;
      currentWord = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    double cellSize = 40.0; // Set a fixed cell size
    double gridSizePx = gridSize * (cellSize + 4); // Calculate total grid size with spacing

    return Scaffold(
      appBar: AppBar(title: const Text("Find four words that lead to the clue")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Words Found: ${foundWords.length}/4", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Center(
            child: SizedBox(
              width: gridSizePx,
              height: gridSizePx,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridSize,
                  childAspectRatio: 1.0, 
                ),
                itemCount: gridSize * gridSize,
                itemBuilder: (context, index) {
                  int row = index ~/ gridSize;
                  int col = index % gridSize;
                  return GestureDetector(
                    onTap: () => _selectLetter(row, col),
                    child: Container(
                      width: cellSize,
                      height: cellSize,
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: highlighted[row][col] ? (foundWords.contains(currentWord) ? Colors.green : Colors.yellow) : Colors.white,
                        border: Border.all(color: Colors.black),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        grid[row][col],
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _resetSelection,
            child: const Text("Reset Selection"),
          ),
        ],
      ),
    );
  }
}
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mine_sweeper/models/Field.dart';


class GameStateProvider extends ChangeNotifier{
   var _gameBoard = List<List<Field>>();
   var _totalOpenedTiles = 0;

  //game initiation

   void generateFirstBoard(){
     initiateBordFields();
     var bombsPosition = _generateBombs();
     for(int pos in bombsPosition){
       placeBomb(pos);
     }
   }

   void generateNewBoard(){
     initiateBordFields();
     var bombsPosition = _generateBombs();
     for(int pos in bombsPosition){
       placeBomb(pos);
     }
     _totalOpenedTiles = 0;
     notifyListeners();
   }

   List<int> _generateBombs(){
     var _rand = Random();
     int _nextMinePlace;
     var _result = List<int>();
     while(true){
       _nextMinePlace = _rand.nextInt(81);
       if(!_result.contains(_nextMinePlace))
         _result.add(_nextMinePlace);
       if(_result.length == 10)
         break;
     }
     return _result;
   }

  void placeBomb(int position){
    final x = position ~/ 9;
    final y = position % 9;
    _gameBoard[x][y].isBomb = true;
      if(x != 0){
        gameBoard[x-1][y].bombCount++;
        if(y != 0)
          gameBoard[x-1][y - 1].bombCount++;
        if(y != 8)
          gameBoard[x-1][y + 1].bombCount++;
      }
      if(x != 8){
        gameBoard[x+1][y].bombCount++;
        if(y != 0)
          gameBoard[x+1][y - 1].bombCount++;
        if(y != 8)
          gameBoard[x+1][y + 1].bombCount++;
      }
      if(y != 0)
        gameBoard[x][y - 1].bombCount++;
      if(y != 8)
        gameBoard[x][y + 1].bombCount++;
  }

  void initiateBordFields(){
    _gameBoard.clear();
    for(int i = 0; i < 9; i++){
      var tempList = List<Field>();
      for(int j = 0; j < 9; j++)
        tempList.add(Field());
      _gameBoard.add(tempList);
    }
  }

  List<List<Field>> get gameBoard => _gameBoard;

   //game initiation end

  //fields handling
  void openHandler(BuildContext ctx, int x, int y){
    gameBoard[x][y].isOpen = true;
    _totalOpenedTiles++;
    if(gameBoard[x][y].isBomb)
      loseAlert(ctx);
    if(_isWinCondition())
      winAlert(ctx);
    notifyListeners();

    if(!_gameBoard[x][y].isBomb && (_gameBoard[x][y].bombCount == 0)) {
      if(x!=0 && !_gameBoard[x-1][y].isOpen && !_gameBoard[x-1][y].isFlagged )
        openHandler(ctx, x-1, y);
      if(x!=8 && !_gameBoard[x+1][y].isOpen && !_gameBoard[x+1][y].isFlagged)
        openHandler(ctx, x+1, y);
      if(y!=0 && !_gameBoard[x][y-1].isOpen && !_gameBoard[x][y-1].isFlagged)
        openHandler(ctx, x, y-1);
      if(y!=8 && !_gameBoard[x][y+1].isOpen && !_gameBoard[x][y+1].isFlagged)
        openHandler(ctx, x, y+1);
      if(y!=8 && x!=8 && !_gameBoard[x+1][y+1].isOpen && !_gameBoard[x+1][y+1].isFlagged)
        openHandler(ctx, x+1, y+1);
      if(y!=0 && x!=0 && !_gameBoard[x-1][y-1].isOpen && !_gameBoard[x-1][y-1].isFlagged)
        openHandler(ctx, x-1, y-1);
      if(y!=8 && x!=0 && !_gameBoard[x-1][y+1].isOpen && !_gameBoard[x-1][y+1].isFlagged)
        openHandler(ctx, x-1, y+1);
      if(y!=0 && x!=8 && !_gameBoard[x+1][y-1].isOpen && !_gameBoard[x+1][y-1].isFlagged)
        openHandler(ctx, x+1, y-1);
    }
  }

  void toggleFlag(int x, int y){
     gameBoard[x][y].isFlagged = !gameBoard[x][y].isFlagged;
     notifyListeners();
   }
   //fields handling end

  //win and lose handler functions

  bool _isWinCondition(){
     return _totalOpenedTiles >= 71;
  }


  Future<void> winAlert(BuildContext ctx) {
    return showDialog(context: ctx, barrierDismissible: false, builder: (ctx) {
      return AlertDialog(
        title: Text("You did it!"),
        content: Text("You finde all mines!"),
        actions: <Widget>[
          FlatButton(child: Text("Start new game?"), onPressed: () {
            generateNewBoard();
            Navigator.of(ctx).pop();
          }),
        ],
      );
    });
  }

  Future<void> loseAlert(BuildContext ctx){
    print("loase aller toggled");
    return showDialog(context: ctx, barrierDismissible: false, builder: (ctx) {
      return AlertDialog(
        title: Text("Wasted!"),
        content: Text("You steped on a mine!"),
        actions: <Widget>[
          FlatButton(child: Text("Start new game?"), onPressed: () {
            generateNewBoard();
            Navigator.of(ctx).pop();
          }),
        ],
      );
    });
  }
//win and lose handler functions end
}
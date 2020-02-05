import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mine_sweeper/models/Field.dart';
import 'package:provider/provider.dart';
import 'package:mine_sweeper/providers/GameStateProvider.dart';

class FieldTile extends StatefulWidget {
  final int position;
  FieldTile(this.position);

  @override
  _FieldTileState createState() => _FieldTileState();
}

class _FieldTileState extends State<FieldTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameStateProvider>(
      builder: (ctx, provider, child) {
        final x = widget.position ~/ 9;
        final y = widget.position % 9;

        final decoration = BoxDecoration(
            color: Colors.grey,
            border: Border(
                top: BorderSide(color: Colors.white, width: 3),
                left: BorderSide(color: Colors.white, width: 3),
                right: BorderSide(color: Colors.black26, width: 3),
                bottom: BorderSide(color: Colors.black26, width: 3)));

        if (provider.gameBoard[x][y].isFlagged) {
          return Center(
            child: GestureDetector(
              onLongPress: (){
                provider.toggleFlag(x, y);
              },
              child: Container(
                decoration: decoration,
                child: Icon(Icons.flag, size: 40),
              ),
            ),
          );
        }

        if (!provider.gameBoard[x][y].isOpen)
          return GestureDetector(
            child: Container(decoration: decoration),
            onTap: () {
                provider.openHandler(context, x, y);

            },
            onLongPress: (){
                provider.toggleFlag(x, y);
            },
          );

        if (provider.gameBoard[x][y].isOpen && provider.gameBoard[x][y].isBomb) {


          return Center(
            child: Container(
              child: Icon(
                Icons.gps_off,
              ),
            ),
          );
        }

        if (provider.gameBoard[x][y].isOpen)
          return Center(
              child: Container(
            child: Text('${provider.gameBoard[x][y].bombCount}'),
          ));


        return null;
      },
    );
  }
}

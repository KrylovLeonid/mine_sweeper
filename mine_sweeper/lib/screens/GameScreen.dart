import 'package:flutter/material.dart';
import 'package:mine_sweeper/widgets/FieldTile.dart';
import 'package:provider/provider.dart';
import 'package:mine_sweeper/providers/GameStateProvider.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<GameStateProvider>(context, listen: false).generateFirstBoard();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Column(
          children: <Widget>[
            Center(
              child: FlatButton(
                child: Text("New Game"),
                onPressed: () {
                  Provider.of<GameStateProvider>(context, listen: false)
                      .generateNewBoard();
                },
              ),
            ),
            Container(
                height: 450,
                child: GridView.count(
                  crossAxisCount: 9,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  children: List.generate(81, (index) {
                    return FieldTile(index);
                  }),
                )),
          ],
        ),
      ),
    );
  }



}

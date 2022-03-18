import 'package:flutter/material.dart';

class Test5 extends StatelessWidget {
  const Test5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GridView.count(
      crossAxisCount: 4,
      children: new List<Widget>.generate(16, (index) {
        return new GridTile(
          child: new Card(
              color: Colors.blue.shade200,
              child: new Center(
                child: new Text('tile $index'),
              )),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';

class CheckBoxListTileExample extends StatefulWidget {
  @override
  _CheckBoxListTileExampleState createState() =>
      _CheckBoxListTileExampleState();
}

class _CheckBoxListTileExampleState extends State<CheckBoxListTileExample> {
  List<Data> _data = [
    Data(title: "Option ", subTitle: "Description", isSelected: false),
    Data(title: "Option ", subTitle: "Description", isSelected: false),
    Data(title: "Option ", subTitle: "Description", isSelected: false),
    Data(title: "Option ", subTitle: "Description", isSelected: false),
    Data(title: "Option ", subTitle: "Description", isSelected: false),
  ];
  @override
  Widget build(BuildContext context) {
   /* return Scaffold(
      appBar: AppBar(
        title: Text("Check Box ListTile Example"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30,right: 30),
        child: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
               controlAffinity: ListTileControlAffinity.leading,
              secondary: Icon(Icons.person),
              title: Text(
                _data[index].title + " " + (index + 1).toString(),
              ),
              subtitle: Text(
                _data[index].subTitle + " " + (index + 1).toString(),
              ),
              value: _data[index].isSelected,
              onChanged: (val) {
                setState(
                  () {
                    _data[index].isSelected = val!;
                  },
                );
              },
            );
          },
        ),
      ),
    );
  */
   return Padding(
        padding: const EdgeInsets.only(left: 30,right: 30),
        child: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
               controlAffinity: ListTileControlAffinity.leading,
             // secondary: Icon(Icons.person),
              title: Text(
                _data[index].title + " " + (index + 1).toString(),
              ),
              /*subtitle: Text(
                _data[index].subTitle + " " + (index + 1).toString(),
              ),*/
              value: _data[index].isSelected,
              onChanged: (val) {
                setState(
                  () {
                    _data[index].isSelected = val!;
                  },
                );
              },
            );
          },
        ),
      
    );
  
  }
}

class Data {
  final String title, subTitle;
  bool isSelected;

  Data({required this.isSelected, required this.title, required this.subTitle});
}
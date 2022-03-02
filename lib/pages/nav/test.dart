import 'package:flutter/material.dart';

class TestDropDown extends StatefulWidget {
  const TestDropDown({Key? key}) : super(key: key);

  @override
  _TestDropDownState createState() => _TestDropDownState();
}

class _TestDropDownState extends State<TestDropDown> {
   late String _selectedValue = 'Android' ;
  List<DropdownMenuItem<String>> items = [
    'Android',
    'IOS',
    'Flutter',
    'Node',
    'Java',
    'Python',
    'PHP',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(
        value,
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
    );
  }).toList();

  late String positions;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DROPDOWN WIDGET'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),

            // Write a new DropdownButton with adding styling.
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(),
                  color: Colors.cyanAccent),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  icon: Icon(Icons.arrow_drop_down_circle,
                      color: Colors.grey.withOpacity(0.7)),
                  items: items,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedValue = value!;
                    });
                    print('----- value ------');
                    print(_selectedValue);
                  },
                  hint: Text(
                    "Please choose a langauage",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  value: _selectedValue,
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            // Use DIY widget from class (very clean code)
            /* DropdownWidgetQ(
                items: ['Frontend', 'Backend', 'DevOps', 'Support', 'PM'],
                onChanged: (value) {
                  print('--- position ---');
                  print(value);
                  setState(() {
                    positions = value;
                  });
                },
                hint: 'Select you positon',
                value: positions)*/
          ],
        ),
      ),
    );
  }
}

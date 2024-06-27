import 'package:dipchip/dipchip/screen/index.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyRequestList());

class MyRequestList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'รายการคำขอสินเชื่อ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CardListScreen(),
    );
  }
}

void _showDetails(BuildContext context, Map<String, String> item) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("รายละเอียด"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("ชื่อ: ${item['ชื่อ']}"),
            Text("นามสกุล: ${item['นามสกุล']}"),
            Text("เลขบัตรประชาชน: ${item['เลขบัตรประชาชน']}"),
            Text("วันที่ขอ: ${item['วันที่ขอ']}"),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text("ปิด"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class CardListScreen extends StatelessWidget {
  final List<Map<String, String>> items = List<Map<String, String>>.generate(
    10,
    (index) => {
      "ชื่อ": "ชื่อ $index",
      "นามสกุล": "นามสกุล $index",
      "เลขบัตรประชาชน": "1234567890123$index",
      "วันที่ขอ": "2024-06-26",
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFC9AE9A),
          title: Text(
            'รายการคำขอสินเชื่อ',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          )),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => IdCard()))
              // _showDetails(context, items[index])
            },
            child: Card(
              margin: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "ชื่อ: ${items[index]['ชื่อ']}",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "นามสกุล: ${items[index]['นามสกุล']}",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "เลขบัตรประชาชน: ${items[index]['เลขบัตรประชาชน']}",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "วันที่ขอ: ${items[index]['วันที่ขอ']}",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

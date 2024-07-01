import 'package:dipchip/dipchip/screen/index.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyRequestList());

class MyRequestList extends StatelessWidget {
  const MyRequestList({super.key});

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
        title: const Text("รายละเอียด"),
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
            child: const Text("ปิด"),
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

  CardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFFC9AE9A),
          title: const Text(
            'รายการคำขอสินเชื่อ',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          )),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => const IdCard()))
              // _showDetails(context, items[index])
            },
            child: Card(
              margin: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "ชื่อ: ${items[index]['ชื่อ']}",
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      "นามสกุล: ${items[index]['นามสกุล']}",
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      "เลขบัตรประชาชน: ${items[index]['เลขบัตรประชาชน']}",
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      "วันที่ขอ: ${items[index]['วันที่ขอ']}",
                      style: const TextStyle(fontSize: 16.0),
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

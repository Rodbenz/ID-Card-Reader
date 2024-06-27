import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:dipchip/dipchip/screen/index.dart'; // Import the file where globalCardData is declared

void main() {
  runApp(MyTest());
}

class MyTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFC9AE9A),
          title: Text(
            'ถ่ายรูปบัตรประชาชน',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: globalCardData != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (globalCardData!.photo.isNotEmpty)
                      Image.memory(Uint8List.fromList(globalCardData!.photo)),
                    SizedBox(height: 10),
                    if (globalCardData!.gender != null)
                      Text('เพศ: ${globalCardData!.gender == 1 ? 'ชาย' : 'หญิง'}'),
                    SizedBox(height: 10),
                    if (globalCardData!.cid != null)
                      Text('เลขบัตรประชาชน: ${globalCardData!.cid}'),
                    SizedBox(height: 10),
                    if (globalCardData!.firstnameTH != null &&
                        globalCardData!.lastnameTH != null)
                      Text(
                          'ชื่อ-นามสกุล (ภาษาไทย): ${globalCardData!.titleTH} ${globalCardData!.firstnameTH} ${globalCardData!.lastnameTH}'),
                    SizedBox(height: 10),
                    if (globalCardData!.firstnameEN != null &&
                        globalCardData!.lastnameEN != null)
                      Text(
                          'ชื่อ-นามสกุล (ภาษาอังกฤษ): ${globalCardData!.titleEN} ${globalCardData!.firstnameEN} ${globalCardData!.lastnameEN}'),
                    SizedBox(height: 10),
                    if (globalCardData!.birthdate != null)
                      Text('วันเดือนปีเกิด: ${globalCardData!.birthdate}'),
                    SizedBox(height: 10),
                    if (globalCardData!.address != null)
                      Text('ที่อยู่: ${globalCardData!.address}'),
                    SizedBox(height: 10),
                    if (globalCardData!.issueDate != null)
                      Text('วันออกบัตร: ${globalCardData!.issueDate}'),
                    SizedBox(height: 10),
                    if (globalCardData!.expireDate != null)
                      Text('วันหมดอายุ: ${globalCardData!.expireDate}'),
                  ],
                )
              : Text('No data available'),
        ),
      ),
    );
  }
}

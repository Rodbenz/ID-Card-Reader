import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thai_idcard_reader_flutter/thai_idcard_reader_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:dipchip/dipchip/screen/display_info.dart';
import 'package:dipchip/dipchip/screen/empty_header.dart';
import 'package:dipchip/dipchip/screen/usb_device_card.dart';

void main() {
  Intl.defaultLocale = 'th_TH';
  initializeDateFormatting('th_TH', null);
  runApp(const IdCard());
}

class IdCard extends StatefulWidget {
  const IdCard({Key? key}) : super(key: key);

  @override
  State<IdCard> createState() => _IdCardState();
}

class _IdCardState extends State<IdCard> {
  ThaiIDCard? _data;
  var _error;
  UsbDevice? _device;
  var _card;
  StreamSubscription? subscription;
  final List _idCardType = [
    ThaiIDType.cid,
    ThaiIDType.photo,
    ThaiIDType.nameTH,
    ThaiIDType.nameEN,
    ThaiIDType.gender,
    ThaiIDType.birthdate,
    ThaiIDType.address,
    ThaiIDType.issueDate,
    ThaiIDType.expireDate,
  ];
  List<String> selectedTypes = [];

  @override
  // void initState() {
  //   super.initState();
  //   ThaiIdcardReaderFlutter.deviceHandlerStream.listen(_onUSB);
  // }
  void _onClick(){
    ThaiIdcardReaderFlutter.deviceHandlerStream.listen(_onUSB);
  }

  void _onUSB(usbEvent) {
    try {
      if (usbEvent.hasPermission) {
        subscription = ThaiIdcardReaderFlutter.cardHandlerStream.listen(_onData);
      } else {
        if (subscription == null) {
          subscription?.cancel();
          subscription = null;
        }
        _clear();
      }
      setState(() {
        _device = usbEvent;
      });
    } catch (e) {
      setState(() {
        _error = "_onUSB " + e.toString();
      });
    }
  }

  void _onData(readerEvent) {
    try {
      setState(() {
        _card = readerEvent;
      });
      if (readerEvent.isReady) {
        readCard(only: selectedTypes);
      } else {
        _clear();
      }
    } catch (e) {
      setState(() {
        _error = "_onData " + e.toString();
      });
    }
  }

  readCard({List<String> only = const []}) async {
    try {
      var response = await ThaiIdcardReaderFlutter.read(only: only);
      setState(() {
        _data = response;
      });
    } catch (e) {
      setState(() {
        _error = 'ERR readCard $e';
      });
    }
  }

  formattedDate(dt) {
    try {
      DateTime dateTime = DateTime.parse(dt);
      String formattedDate = DateFormat.yMMMMd('th_TH').format(dateTime);
      return formattedDate;
    } catch (e) {
      return dt.split('').toString() + e.toString();
    }
  }

  _clear() {
    setState(() {
      _data = null;
    });
  }

  @override
  Widget build(BuildContext context) {
     print(_data);
    return MaterialApp(
      home: Scaffold(
        // ******************** Nav Bar = AppBar ******************** //
        appBar: AppBar(
          backgroundColor: Color(0xFFC9AE9A),
          title: Text(
            'ตรวจสอบข้อมูล',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        // ******************** Nav Bar = AppBar ******************** //

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // if (_device != null)
                // UsbDeviceCard(
                //   device: _device,
                // ),
              if (_card != null) Text(_card.toString()),
              if (_device == null || !_device!.isAttached) ...[
                const EmptyHeader(
                  text: 'เสียบเครื่องอ่านบัตรก่อน',
                ),
              ],
              // if (_error != null) Text(_error.toString()),
              if (_data == null && (_device != null && _device!.hasPermission)) ...[
                const EmptyHeader(
                  icon: Icons.credit_card,
                  text: 'เสียบบัตรประชาชนได้เลย',
                ),
                // SizedBox(
                //   height: 200,
                //   child: Wrap(children: [
                //     Row(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Checkbox(
                //             value: selectedTypes.isEmpty,
                //             onChanged: (val) {
                //               setState(() {
                //                 if (selectedTypes.isNotEmpty) {
                //                   selectedTypes = [];
                //                 }
                //               });
                //             }),
                //         const Text('readAll'),
                //       ],
                //     ),
                //     for (var ea in _idCardType)
                //       Row(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           Checkbox(
                //               value: selectedTypes.contains(ea),
                //               onChanged: (val) {
                //                 print(ea);
                //                 setState(() {
                //                   if (selectedTypes.contains(ea)) {
                //                     selectedTypes.remove(ea);
                //                   } else {
                //                     selectedTypes.add(ea);
                //                   }
                //                 });
                //               }),
                //           // Text('$ea'),
                //         ],
                //       ),
                //   ]),
                // ),
              ],

              // **************************************| โค้ดต้นฉบับจาก Package |************************************** //

               if (_data != null)
               ...[
                const Padding(padding: EdgeInsets.all(8.0)),
                if (_data!.photo.isNotEmpty)
                  Center(
                    child: Image.memory(
                      Uint8List.fromList(_data!.photo),
                    ),
                  ),

                SizedBox(height: 16),

                if (_data!.gender != null)
                DisplayInfo(
                  title: 'เพศ',
                  value: '${_data!.gender == 1 ? 'ชาย' : 'หญิง'}',
                  valueTextStyle: TextStyle(fontSize: 16), // ปรับขนาดตามที่ต้องการ
                ),

                SizedBox(height: 16),

                if (_data!.cid != null)
                  DisplayInfo(title: 'เลขบัตรประชาชน', 
                  value: _data!.cid!,
                  valueTextStyle: TextStyle(fontSize: 16), // ปรับขนาดตามที่ต้องการ
                ),

                SizedBox(height: 16),

                if (_data!.firstnameTH != null && _data!.lastnameTH != null)
                  DisplayInfo(
                    title: 'ชื่อ-นามสกุล (ภาษาไทย)',
                    value: '${_data!.titleTH} ${_data!.firstnameTH} ${_data!.lastnameTH}',
                    valueTextStyle: TextStyle(fontSize: 16), // ปรับขนาดตามที่ต้องการ
                ),

                SizedBox(height: 16),

                if (_data!.firstnameEN != null && _data!.lastnameEN != null)
                  DisplayInfo(
                    title: 'ชื่อ-นามสกุล (ภาษาอังกฤษ)',
                    value: '${_data!.titleEN} ${_data!.firstnameEN} ${_data!.lastnameEN}',
                    valueTextStyle: TextStyle(fontSize: 16), // ปรับขนาดตามที่ต้องการ
                ),

                SizedBox(height: 16),

                if (_data!.birthdate != null)
                  DisplayInfo(
                    title: 'วันเดือนปีเกิด',
                    value: '${_data!.birthdate.toString()}', // value: '${_data!.birthdate.toString()}\n${formattedDate(_data!.birthdate)}',
                    valueTextStyle: TextStyle(fontSize: 16), // ปรับขนาดตามที่ต้องการ
                ),

                SizedBox(height: 16),

                if (_data!.address != null)
                  DisplayInfo(
                    title: 'ที่อยู่',
                    value: _data!.address!,
                    valueTextStyle: TextStyle(fontSize: 16), // ปรับขนาดตามที่ต้องการ
                ),

                SizedBox(height: 16),

                if (_data!.issueDate != null)
                  DisplayInfo(
                    title: 'วันออกบัตร',
                    value: '${_data!.issueDate.toString()}', // value: '${_data!.issueDate.toString()}\n${formattedDate(_data!.issueDate)}',
                    valueTextStyle: TextStyle(fontSize: 16), // ปรับขนาดตามที่ต้องการ
                ),

                SizedBox(height: 16),

                if (_data!.expireDate != null)
                  DisplayInfo(
                    title: 'วันหมดอายุ',
                    value: '${_data!.expireDate.toString()}', // value: '${_data!.expireDate.toString()}\n${formattedDate(_data!.expireDate)}',
                    valueTextStyle: TextStyle(fontSize: 16), // ปรับขนาดตามที่ต้องการ
                  ),
                SizedBox(height: 16),
              ],
              // ******************************************************************************************************************************************************** //
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

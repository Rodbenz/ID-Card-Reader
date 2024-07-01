import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DisplayInfo extends StatelessWidget {
  const DisplayInfo({
    super.key,
    required this.title,
    required this.value,
    required this.valueTextStyle,
  });

  final String title;
  final String value;
  final TextStyle valueTextStyle;

  @override
  Widget build(BuildContext context) {
    TextStyle sTitle = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    TextStyle sVal = const TextStyle(fontSize: 18);

    copyFn(value) {
      Clipboard.setData(ClipboardData(text: value)).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("คัดลอกสำเร็จ")));
      });
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '$title : ', style: sTitle,
              ),
              
            ],
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      value,
                      style: sVal,
                    ),
                  ),
                ],
              ),
              // GestureDetector(
              //   onTap: () => _copyFn(value),
              //   child: const Icon(Icons.copy),
              // )
            ],
          ),
          // ======================| เส้นแบ่ง |====================== //
          const Divider(
            height: 2,
            thickness: 2,
            color: Color(0xFF502D1E),
          ),
          // ======================| เส้นแบ่ง |====================== //
        ],
      ),
    );
  }
}

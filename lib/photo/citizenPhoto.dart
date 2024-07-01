import 'dart:io';
import 'package:flutter/material.dart';
import 'package:capture_identity/capture_identity.dart';

void main() {
  runApp(const MyCitizenPhoto(title: ''));
}

class MyCitizenPhoto extends StatefulWidget {
  const MyCitizenPhoto({super.key, required this.title});

  final String title;

  @override
  State<MyCitizenPhoto> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyCitizenPhoto> {
  File? idCapture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () async {
            // Navigate to the CaptureView widget and update the state with the captured image
            idCapture = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CaptureView(
                  fileCallback: (imagePath) {},
                  title: "ถ่ายรูปบัตรประชาชน",
                  hideIdWidget: false,
                ),
              ),
            );
            setState(() {});
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.28,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    width: 3, color: Colors.deepOrange.withOpacity(0.4)),
                image: idCapture == null
                    ? null
                    : DecorationImage(image: FileImage(idCapture!))),
            child: Center(
              child: idCapture == null
                  ? Icon(
                      Icons.camera_alt,
                      color: Colors.deepOrange.withOpacity(0.4),
                      size: 30,
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
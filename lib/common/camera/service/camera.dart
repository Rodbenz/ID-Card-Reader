// ignore_for_file: unused_import

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class Camera {
  final ImagePicker _picker = ImagePicker();

  Future<String?> openCamera(BuildContext context) async {
    try {
      final XFile? picture = await _picker.pickImage(source: ImageSource.camera);
      if (picture != null) {

        print('🥩🥩🥩🥩🥩 ${picture.path} 🥩🥩🥩🥩🥩');

        return picture.path; // ส่งเส้นทางของรูปภาพที่ถ่ายมากลับ
      }
    } catch (e) {
      print('Error opening camera: $e');
    }
    return null;
  }
}

class CameraWidget extends StatefulWidget {
  final String labelText;

  const CameraWidget({super.key, required this.labelText});

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late String _imageFilePath = '';

  void _openCamera() async {
    Camera camera = Camera();
    String? imagePath = await camera.openCamera(context);
    if (imagePath != null) {
      
      setState(() {
        _imageFilePath = imagePath; // อัพเดทเส้นทางของรูปภาพที่ถ่ายมา
      });

      print('🍙🍙🍙🍙🍙🍙🍙🍙🍙🍙🍙🍙 $_imageFilePath 🍙🍙🍙🍙🍙🍙🍙🍙🍙🍙🍙🍙');

    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('รูปภาพถูกบันทึกเรียบร้อยแล้ว'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.file(File(_imageFilePath)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // ปิด AlertDialog
                      _openCamera(); // เปิดกล้องเพื่อถ่ายรูปใหม่
                    },
                    child: const Text(
                      'ลองใหม่',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // ปิด AlertDialog
                      _openCamera(); // เปิดกล้องเพื่อถ่ายรูปใหม่
                    },
                    child: const Text(
                      'ตกลง',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // ปิด AlertDialog
                    },
                    child: const Text(
                      'ปิด',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.labelText,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              _openCamera(); // เปิดกล้องเมื่อคลิกที่ไอคอนกล้อง
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black45,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
                image: _imageFilePath.isNotEmpty
                    ? DecorationImage(
                        image: FileImage(
                            File(_imageFilePath)), // แสดงรูปภาพที่ถ่ายมา
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: _imageFilePath.isEmpty
                  ? const Icon(
                      Icons.camera_alt,
                      size: 80,
                      color: Colors.black,
                    )
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _showDialog, // เมื่อกดปุ่มนี้จะแสดง AlertDialog
          child: const Text(
            'ถ่ายรูป',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
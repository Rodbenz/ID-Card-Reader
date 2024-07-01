import 'package:dipchip/RequestList/index.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart'; // สำหรับ Load หน้าเข้าใช้แอปพลิเคชันก่อนถึง Logo เข้าใช้งาน

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const double _kSize = 100.0; // ขนาดของ loading animation
  bool _isLoadingComplete = false; // สถานะการโหลด

  @override
  void initState() {
    super.initState();
    _loadHomePage();
  }

  void _loadHomePage() async {
    print('🔄🔄🔄🔄🔄 Loading Page 🔄🔄🔄🔄🔄');

    // แสดง loading animation widget ก่อน
    await Future.delayed(const Duration(milliseconds: 2500));

    // ตรวจสอบเงื่อนไขอินเทอร์เน็ต หรือสถานะอื่นๆที่มีผลต่อการโหลด
    bool isInternetSlow = true; // ตั้งค่าเป็น true หรือ false ตามสถานะของอินเทอร์เน็ต

    if (isInternetSlow) {
      // หากอินเทอร์เน็ตช้า หรือเครื่องเปิดช้าให้รอเวลาเพิ่มอีก milliseconds: 2500
      await Future.delayed(const Duration(milliseconds: 2500));
    }

    // เมื่อโหลดเสร็จสิ้น ให้เปลี่ยนสถานะเพื่อแสดงรูปภาพ
    setState(() {
      _isLoadingComplete = true;
    });

    // รอสักครู่ก่อนเปลี่ยนหน้า
    await Future.delayed(const Duration(milliseconds: 1500));

    print('💦💦💦💦💦 Next Page : OpenWork (เปิดงาน) 💦💦💦💦💦');

    // เมื่อรีโหลดเสร็จสิ้น ให้เปลี่ยนหน้าไปยังหน้าหลัก (OpenWorkPage)
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyRequestList()));
    //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => IdCard()));

  }

// *************************************************| สำหรับตรวจสอบการเชื่อมต่ออินเทอร์เน็ตในการเข้าใช้งาน |************************************************* //
  //   void _loadHomePage() async {
  //   // รอเวลา 2 วินาที (2000 มิลลิวินาที) สำหรับการแสดง loading animation ก่อน
  //   await Future.delayed(Duration(milliseconds: 2500));
  //   // ตรวจสอบเงื่อนไขอินเทอร์เน็ต หรือสถานะอื่น ๆ ที่มีผลต่อการโหลด
  //   // bool isInternetSlow = true; // ตั้งค่าเป็น true หรือ false ตามสถานะของอินเทอร์เน็ต  
  //   // ตรวจสอบการเชื่อมต่ออินเทอร์เน็ต
  //   var connectivityResult = await Connectivity().checkConnectivity();
  //   if (connectivityResult == ConnectivityResult.none) {
  //     // หากไม่มีการเชื่อมต่ออินเทอร์เน็ต ให้รอเชื่อมต่ออีก 3 วินาที (3000 มิลลิวินาที)
  //     await _waitForInternetConnection();
  //   }
  //   // เมื่อโหลดเสร็จสิ้น ให้เปลี่ยนสถานะเพื่อแสดงรูปภาพ
  //   setState(() {
  //     _isLoadingComplete = true;
  //   });
  //   // รอสักครู่ก่อนเปลี่ยนหน้า
  //   await Future.delayed(Duration(milliseconds: 1500));
  //   // เมื่อรีโหลดเสร็จสิ้น ให้เปลี่ยนหน้าไปยังหน้าหลัก (OpenWorkPage)
  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OpenWorkPage()),
  //   );
  // }
  // // Method สำหรับรอเชื่อมต่ออินเทอร์เน็ต
  // Future<void> _waitForInternetConnection() async {
  //   var connectivityResult = await Connectivity().checkConnectivity();
  //   while (connectivityResult == ConnectivityResult.none) {
  //     // รอเชื่อมต่ออินเทอร์เน็ตอีก 1 วินาที (1000 มิลลิวินาที) ก่อนที่จะตรวจสอบอีกครั้ง
  //     await Future.delayed(Duration(milliseconds: 1000));
  //     connectivityResult = await Connectivity().checkConnectivity();
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    print('🎠🎠🎠🎠 Splash Screen 🎠🎠🎠🎠'); // สำหรับอ่านใน Terminal

    return Scaffold(
      backgroundColor: const Color(0xFFDCCCBD),
      body: Center(
        child: _isLoadingComplete
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo/logo.png',
                    width: 300.0,
                    height: 300.0,
                  ),
                ],
              )
            : LoadingAnimationWidget.horizontalRotatingDots(
                color: const Color(0xFF502D1E),
                size: _kSize,
              ),
      ),
    );
  }
}

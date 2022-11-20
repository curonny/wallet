import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wallet/controllers/paymentController.dart';
import 'package:wallet/screens/aboutUsScreen.dart';
import 'package:wallet/screens/homeScreen.dart';

import 'buyAppScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PaymentController get paymentController => Get.put(PaymentController());

  GetStorage getStorage = GetStorage();
  @override
  void initState() {
    donLogin();
    super.initState();
  }

  void donLogin() {
    Future.delayed(const Duration(seconds: 3), () async {
      Get.offAll(HomeScreen());
      // if (GetPlatform.isAndroid) {
      //   if (paymentController.dwalletPurchased.value) {
      //     Get.offAll(HomeScreen());
      //   } else {
      //     Get.offAll(BuyAppScreen());
      //   }
      // } else {
      //   Get.offAll(HomeScreen());
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffa6d8be),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Image.asset('assets/image/playstore.png'),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Su billetera electrónica para documentos importantes",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Obx(() => paymentController.isLoadingStatus.value
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.black,
                  ))
                : const SizedBox())
          ],
        ),
      ),
    );
  }
}

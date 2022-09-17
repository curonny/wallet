import 'package:apklis_payment_checker/apklis_payment_checker.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final String packageId = "com.curonny.dwallet";

  RxBool isLoadingStatus = false.obs;

  RxBool dwalletPurchased = false.obs;
  RxBool apkListInstalled = false.obs;

  @override
  void onInit() async {
    super.onInit();
    checkDWalletStatus();
  }

  void checkDWalletStatus() async {
    isLoadingStatus.value = true;
    var dWalletStatus = await ApklisPaymentChecker.isPurchased(packageId);
    var apklisInfo = await ApklisPaymentChecker.getApklisInfo();

    print(apklisInfo.isInstalled);

    dwalletPurchased.value = dWalletStatus.paid;
    apkListInstalled.value = apklisInfo.isInstalled;
    print(dWalletStatus.paid);
    print(dWalletStatus.username);
    isLoadingStatus.value = false;
  }
}

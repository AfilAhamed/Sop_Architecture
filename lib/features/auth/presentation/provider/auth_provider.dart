import 'package:flutter/material.dart';
import 'package:task/features/auth/repo/i_auth_impl.dart';

class AuthProvider extends ChangeNotifier {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final AuthRepository authRepository = AuthRepository();

  //login using phone number
  void loginWithPhoneNumber(BuildContext context) {
    String phoneNumber = numberController.text.trim();

    if (!phoneNumber.startsWith("+91")) {
      phoneNumber = "+91$phoneNumber";
    }
    authRepository.loginWithPhoneNumber(context, phoneNumber);
    notifyListeners();
  }

  //otp submition
  Future<void> otpSubmit(String verificationId) async {
    await authRepository.otpSubmit(otpController.text, verificationId);
    notifyListeners();
  }
}

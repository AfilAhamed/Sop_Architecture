import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task/features/auth/presentation/provider/auth_provider.dart';
import 'package:task/general/services/toast_messages.dart';
import 'package:task/general/utils/app_images.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Center(
                    child: Image.asset(
                  AppImages.loginScreenImage,
                  height: mq.height * 0.2,
                  width: mq.width * 0.4,
                  fit: BoxFit.contain,
                )),
                SizedBox(
                  height: mq.height * 0.050,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Enter Phone Number',
                      style: GoogleFonts.montserrat(
                          fontSize: 18, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                SizedBox(
                  height: mq.height * 0.02,
                ),
                Consumer<AuthProvider>(
                  builder: (context, loginProvider, child) {
                    return TextFormField(
                      controller: loginProvider.numberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a number';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        hintText: 'Enter Phone Number *',
                        hintStyle: GoogleFonts.montserrat(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2,
                            )),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: mq.height * 0.03,
                ),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.montserrat(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    children: [
                      const TextSpan(
                          text: 'By Continuing, I agree to TotalX’s '),
                      TextSpan(
                        text: 'Terms and condition',
                        style: TextStyle(color: Colors.blue.shade300),
                      ),
                      const TextSpan(text: ' & '),
                      TextSpan(
                        text: 'privacy Policy',
                        style: TextStyle(color: Colors.blue.shade300),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: mq.height * 0.04,
                ),
                SizedBox(
                    height: mq.height * 0.066,
                    width: double.infinity,
                    child: Consumer<AuthProvider>(
                      builder: (context, loginProvider, child) {
                        return ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.black)),
                            onPressed: () {
                              if (loginProvider
                                  .numberController.text.isNotEmpty) {
                                loginProvider.loginWithPhoneNumber(context);
                              } else {
                                ToastMessage.showMessage(
                                    'Please enter the number', Colors.red);
                              }
                            },
                            child: Text(
                              'Get OTP',
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ));
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

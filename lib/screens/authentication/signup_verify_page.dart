// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ommyfitness/common/message_dialog.dart';

import 'package:ommyfitness/common/option_view.dart';
import 'package:ommyfitness/common/phone_number_filter.dart';
import 'package:ommyfitness/common/sizeConfig.dart';
import 'package:ommyfitness/providers/authentication/authentication_service.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ommyfitness/providers/shared_preferences/shared_preferences_provider.dart';
import 'package:ommyfitness/utils/colours.dart';
import 'package:ommyfitness/utils/routes.dart';

class SignUpVerifyPage extends ConsumerStatefulWidget {
  final String phoneNumber;
  const SignUpVerifyPage({required this.phoneNumber, Key? key})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignUpVerifyPageState();
}

class _SignUpVerifyPageState extends ConsumerState<SignUpVerifyPage> {
  OtpFieldController otpController = OtpFieldController();
  String otpPin = "";
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("sign up verify page");
    return Scaffold(
      backgroundColor: purpleBackgroundColor,
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Enter Code",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: SizeConfig.screenHeight(context) * 0.08,
                      ),
                      Text("We have sent verification code to",
                          style: TextStyle(
                              color: Colors.white.withOpacity(
                                0.5,
                              ),
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      Text(widget.phoneNumber,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: greyColor02)),
                      SizedBox(
                        height: SizeConfig.screenHeight(context) * 0.1,
                      ),
                      Center(
                        child: OTPTextField(
                            otpFieldStyle: OtpFieldStyle(
                              borderColor: Colors.white.withOpacity(
                                0.5,
                              ),
                              enabledBorderColor: Colors.white.withOpacity(
                                0.5,
                              ),
                            ),
                            controller: otpController,
                            length: 4,
                            width: MediaQuery.of(context).size.width,
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldWidth: 45,
                            fieldStyle: FieldStyle.box,
                            outlineBorderRadius: 10,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white.withOpacity(
                                0.5,
                              ),
                            ),
                            onChanged: (pin) {},
                            onCompleted: (pin) {
                              setState(() {
                                otpPin = pin;
                              });
                            }),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight(context) * 0.09,
                      ),
                      Row(
                        children: [
                          Text(
                            "Didn't Get phoneNumber?",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white.withOpacity(
                                0.5,
                              ),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isLoading = true;
                                });
                                final formattedNumber =
                                    phoneNumberFilter(widget.phoneNumber);
                                ref
                                    .read(authServiceProvider)
                                    .verifyUserSendOtp(
                                        phoneNumber: formattedNumber)
                                    .then((value) {
                                  if (value['status'] == 'success') {
                                    messageDialog(context, value['status'],
                                        value['message']);
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                });
                              },
                              child: const Text(
                                "Resend",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight(context) * 0.04,
                      ),
                      Row(
                        children: [
                          Text(
                            "Doesn't Have An Account?",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white.withOpacity(
                                0.5,
                              ),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: InkWell(
                              onTap: () {
                                goRouter.goNamed('signUp');
                              },
                              child: const Text(
                                "SignUp",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight(context) * 0.04,
                      ),
                      Row(
                        children: [
                          Text(
                            "Already Have An Account?",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(
                                0.5,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: InkWell(
                              onTap: () {
                                goRouter.goNamed('signIn');
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight(context) * 0.09,
                      ),
                      InkWell(
                        onTap: () {
                          final formattedNumber =
                              phoneNumberFilter(widget.phoneNumber);
                          setState(() {
                            isLoading = true;
                          });
                          ref
                              .read(authServiceProvider)
                              .verifySignUpOtp(
                                  phoneNumber: formattedNumber, otp: otpPin)
                              .then((value) {
                            if (value['status'] == 'success') {
                              saveUserDetails() async {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                preferences.setBool("logged", true);
                                preferences.setString(
                                    "user_id", value['user_id']);
                                preferences.setString("token", value['token']);
                                preferences.setString(
                                    "user_name", value['username']);
                                ref.refresh(sharedPreferenceInstanceProvider);
                                ref.refresh(isLoggedInProvider);
                                ref.refresh(userNameProvider);
                                ref.refresh(tokenProvider);
                              }

                              saveUserDetails();
                              messageDialog(
                                  context, value['status'], value['message']);
                              goRouter.goNamed('home');
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              messageDialog(
                                  context, value['status'], value['message']);
                            }
                          });
                        },
                        child: Center(
                          child: SizedBox(
                            width: SizeConfig.screenWidth(context),
                            child: OptionView(
                              purpleforever,
                              "Verify",
                              padding: 15,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

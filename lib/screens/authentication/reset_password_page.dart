import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ommyfitness/common/message_dialog.dart';

import 'package:ommyfitness/common/option_view.dart';
import 'package:ommyfitness/common/phone_number_filter.dart';
import 'package:ommyfitness/common/sizeConfig.dart';
import 'package:ommyfitness/common/textfield_widget.dart';
import 'package:ommyfitness/providers/authentication/authentication_service.dart';
import 'package:ommyfitness/utils/colours.dart';
import 'package:ommyfitness/utils/routes.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final TextEditingController phoneNumberController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
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
                      const Text("Reset Password!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: SizeConfig.screenHeight(context) * 0.1,
                      ),
                      TextFieldWidget(
                        texttFieldController: phoneNumberController,
                        hintText: "Phone Number",
                        textInputType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight(context) * 0.07,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight(context) * 0.1,
                      ),
                      Row(
                        children: [
                          Text(
                            "Doesn't Have An Account?",
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
                            "Remember Password?",
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
                              phoneNumberFilter(phoneNumberController.text);

                          if (phoneNumberController.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    right: 10, left: 10, bottom: 10),
                                backgroundColor: blueColor,
                                content: Text("Phone Number is required"),
                              ),
                            );
                          } else if (formattedNumber == 'invalid format') {
                            messageDialog(context, 'Phone Number',
                                'Invalid phone number. Phone number should start with 255... or 0..');
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            ref
                                .read(authServiceProvider)
                                .resetPasswordSendOTP(
                                    phoneNumber: formattedNumber)
                                .then((value) {
                              if (value['status'] == 'success') {
                                messageDialog(
                                    context, value['status'], value['message']);
                                final formattedNumber = phoneNumberFilter(
                                    phoneNumberController.text);
                                ref.read(authServiceProvider).verifyUserSendOtp(
                                    phoneNumber: formattedNumber);
                                context.goNamed('signUpVerify', params: {
                                  'number': phoneNumberController.text
                                });
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                messageDialog(
                                    context, value['status'], value['message']);
                              }
                            });
                          }
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

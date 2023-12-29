import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ommyfitness/common/message_dialog.dart';

import 'package:ommyfitness/common/option_view.dart';
import 'package:ommyfitness/common/phone_number_filter.dart';
import 'package:ommyfitness/common/sizeConfig.dart';
import 'package:ommyfitness/common/textfield_widget.dart';
import 'package:ommyfitness/providers/authentication/authentication_service.dart';
import 'package:ommyfitness/utils/colours.dart';
import 'package:ommyfitness/utils/routes.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController comfirmPasswordController =
      TextEditingController();
  bool obscureText = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    debugPrint("sign up  page");

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
                      const Text("Create An Account",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: SizeConfig.screenHeight(context) * 0.08,
                      ),
                      TextFieldWidget(
                        texttFieldController: usernameController,
                        hintText: "Username",
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight(context) * 0.06,
                      ),
                      TextFieldWidget(
                        texttFieldController: phoneController,
                        hintText: "Phone Number",
                        textInputType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight(context) * 0.06,
                      ),
                      TextFieldWidget(
                        texttFieldController: passwordController,
                        hintText: "Password",
                        obscureText: obscureText,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: Icon(obscureText == false
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash),
                          color: Colors.white.withOpacity(
                            0.5,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight(context) * 0.06,
                      ),
                      TextFieldWidget(
                        texttFieldController: comfirmPasswordController,
                        hintText: "Comfirm Password",
                        obscureText: obscureText,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: Icon(obscureText == false
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash),
                          color: Colors.white.withOpacity(
                            0.5,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight(context) * 0.07,
                      ),
                      Row(
                        children: [
                          Text(
                            "Already Have An Account?",
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
                        height: SizeConfig.screenHeight(context) * 0.05,
                      ),
                      InkWell(
                        onTap: () {
                          if (usernameController.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    right: 10, left: 10, bottom: 10),
                                backgroundColor: blueColor,
                                content: Text('Username is required'),
                              ),
                            );
                          } else if (phoneController.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    right: 10, left: 10, bottom: 10),
                                backgroundColor: blueColor,
                                content: Text('Phone Number is required'),
                              ),
                            );
                          } else if (passwordController.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    right: 10, left: 10, bottom: 10),
                                backgroundColor: blueColor,
                                content: Text('Password is required'),
                              ),
                            );
                          } else if (comfirmPasswordController.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    right: 10, left: 10, bottom: 10),
                                backgroundColor: blueColor,
                                content: Text('Comfirm Password is required'),
                              ),
                            );
                          } else if (passwordController.text !=
                              comfirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    right: 10, left: 10, bottom: 10),
                                backgroundColor: blueColor,
                                content: Text('Password do not match'),
                              ),
                            );
                          } else {
                            final formattedNumber =
                                phoneNumberFilter(phoneController.text);

                            if (formattedNumber == 'invalid format') {
                              messageDialog(context, 'Phone Number',
                                  'Invalid phone number. Phone number should start with 255... or 0..');
                            } else {
                              FocusManager.instance.primaryFocus?.unfocus();
                              setState(() {
                                isLoading = true;
                              });
                              ref
                                  .read(authServiceProvider)
                                  .signUp(
                                      username: usernameController.text,
                                      password: passwordController.text,
                                      phoneNumber: formattedNumber)
                                  .then((value) {
                                debugPrint(value.toString());
                                if (value['status_code'] == 201) {
                                  final formattedNumber =
                                      phoneNumberFilter(phoneController.text);
                                  ref
                                      .read(authServiceProvider)
                                      .verifyUserSendOtp(
                                          phoneNumber: formattedNumber);
                                  context.goNamed('signUpVerify',
                                      params: {'number': phoneController.text});
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  messageDialog(context, value['status'],
                                      value['message']);
                                }
                              });
                            }
                          }
                        },
                        child: Center(
                          child: SizedBox(
                            width: SizeConfig.screenWidth(context),
                            child: OptionView(
                              purpleforever,
                              "SignUp",
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

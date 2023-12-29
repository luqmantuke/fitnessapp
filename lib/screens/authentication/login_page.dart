// ignore_for_file: unused_result

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
import 'package:ommyfitness/providers/shared_preferences/shared_preferences_provider.dart';
import 'package:ommyfitness/utils/colours.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ommyfitness/utils/routes.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool obscureText = true;
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
                      const Text("Welcome Back!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: SizeConfig.screenHeight(context) * 0.1,
                      ),
                      TextFieldWidget(
                        texttFieldController: phoneController,
                        hintText: "Phone Number",
                        textInputType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight(context) * 0.07,
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
                            "Forgot Password?",
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
                                context.goNamed('resetPassword');
                              },
                              child: const Text(
                                "Reset",
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
                              phoneNumberFilter(phoneController.text);

                          if (phoneController.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    right: 10, left: 10, bottom: 10),
                                backgroundColor: blueColor,
                                content: Text("Phone Number is required"),
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
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            ref
                                .read(authServiceProvider)
                                .login(
                                    phoneNumber: formattedNumber,
                                    password: passwordController.text)
                                .then((value) {
                              if (value['status'] == 'success') {
                                saveUserDetails() async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  preferences.setBool("logged", true);
                                  preferences.setString(
                                      "user_id", value['user_id']);
                                  preferences.setString(
                                      "token", value['token']);
                                  preferences.setString(
                                      "user_name", value['username']);
                                  ref.refresh(sharedPreferenceInstanceProvider);
                                  ref.refresh(isLoggedInProvider);
                                  ref.refresh(userNameProvider);
                                  ref.refresh(tokenProvider);
                                  ref.refresh(userIdProvider);
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
                          }
                        },
                        child: Center(
                          child: SizedBox(
                            width: SizeConfig.screenWidth(context),
                            child: OptionView(
                              purpleforever,
                              "Login",
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

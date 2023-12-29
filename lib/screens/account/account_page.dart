// ignore_for_file: unused_result

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ommyfitness/providers/shared_preferences/shared_preferences_provider.dart';
import 'package:ommyfitness/utils/colours.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ommyfitness/utils/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  @override
  void initState() {
    ref.read(sharedPreferenceInstanceProvider);
    ref.read(isLoggedInProvider);
    ref.read(userNameProvider);
    ref.read(tokenProvider);
    super.initState();
  }

  final TextEditingController deleteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.watch(isLoggedInProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Account",
            style: TextStyle(
              color: blackColor,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
        backgroundColor: whiteBackgroundColor,
        elevation: 0.0,
      ),
      body: ListView(shrinkWrap: true, children: [
        InkWell(
          onTap: () {
            var url = 'https://wa.me/+255676372280';

            void launchURL() async {
              if (!await launchUrl(Uri.parse(url),
                  mode: LaunchMode.externalApplication)) {
                throw 'Could not launch $url';
              }
            }

            launchURL();
          },
          child: _accountWidgets(
              FontAwesomeIcons.whatsapp, "Customer Support Whatsapp"),
        ),
        // InkWell(
        //   onTap: () async {
        //     Share.share(
        //         'Nunua Spare Ya Gari Lako Sasa Na Uweze Kulipa Kidogo Kidogo. https://play.google.com/store/apps/details?id=com.tukesolutions.ommyfitness');
        //   },
        //   child: _accountWidgets(
        //     FontAwesomeIcons.share,
        //     "Share With Friends",
        //   ),
        // ),
        // InkWell(
        //   onTap: () {
        //     var url = Platform.isAndroid ? '' : '';

        //     void launchURL() async {
        //       if (!await launchUrl(Uri.parse(url),
        //           mode: LaunchMode.externalApplication)) {
        //         throw 'Could not launch $url';
        //       }
        //     }

        //     launchURL();
        //   },
        //   child: _accountWidgets(
        //       FontAwesomeIcons.googlePlay,
        //       Platform.isAndroid
        //           ? "Rate Us On PlayStore"
        //           : "Rate Us On AppStore"),
        // ),
        InkWell(
          onTap: () {
            var url = 'https://twitter.com/ommyfitness';

            void launchURL() async {
              if (!await launchUrl(Uri.parse(url),
                  mode: LaunchMode.externalApplication)) {
                throw 'Could not launch $url';
              }
            }

            launchURL();
          },
          child:
              _accountWidgets(FontAwesomeIcons.twitter, "Follow Us On Twitter"),
        ),
        InkWell(
          onTap: () {
            var url = 'https://instagram.com/ommyfitness';

            void launchURL() async {
              if (!await launchUrl(Uri.parse(url),
                  mode: LaunchMode.externalApplication)) {
                throw 'Could not launch $url';
              }
            }

            launchURL();
          },
          child: _accountWidgets(
              FontAwesomeIcons.instagram, "Follow Us On Instagram"),
        ),
        InkWell(
          onTap: () {
            goRouter.pushNamed("privacyAndPolicy");
          },
          child:
              _accountWidgets(FontAwesomeIcons.userLock, "Privacy And Policy"),
        ),

        isLoggedIn.maybeWhen(
          orElse: () => const SizedBox(),
          data: (data) => data == true
              ? InkWell(
                  onTap: () async {
                    debugPrint("Cupertino Alert Dialog");
                    showAccountDeleteDialog(context, deleteController);
                  },
                  child:
                      _accountWidgets(FontAwesomeIcons.trash, "Delete Account"),
                )
              : const SizedBox(),
        ),

        // InkWell(
        //   onTap: () {
        //     var url = 'https://www.ommyfitness.com/';

        //     void launchURL() async {
        //       if (!await launchUrl(Uri.parse(url),
        //           mode: LaunchMode.externalApplication)) {
        //         throw 'Could not launch $url';
        //       }
        //     }

        //     launchURL();
        //   },
        //   child: _accountWidgets(FontAwesomeIcons.globe, "Visit Our Website"),
        // ),
      ]),
    );
  }
}

Widget _accountWidgets(IconData icon, String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 22.0,
      horizontal: 15,
    ),
    child: Row(
      children: [
        Container(
          margin: const EdgeInsets.only(
            right: 8,
          ),
          decoration: BoxDecoration(
            color: shinewinter,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            color: purpleColor2,
            size: 15,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
      ],
    ),
  );
}

Future<void> showAccountDeleteDialog(
    BuildContext context, TextEditingController deleteController) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      bool isInputValid = false;
      return StatefulBuilder(
        builder: (context, setState) {
          void validateInput() {
            String inputText = deleteController.text.trim();
            setState(() {
              isInputValid = inputText == "Delete";
            });
          }

          return AlertDialog(
            backgroundColor: purpleBackgroundColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            title: const Text(
              'Delete Account',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            content: const SingleChildScrollView(
              child: Text(
                "Are you sure you want to permanently delete your account?",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
  );
}

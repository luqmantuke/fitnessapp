import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ommyfitness/common/sizeConfig.dart';
import 'package:ommyfitness/utils/colours.dart';
import 'package:ommyfitness/utils/images.dart';
import 'package:ommyfitness/utils/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: purpleBackgroundColor,
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        children: <Widget>[
          SizedBox(
            height: SizeConfig.screenHeight(context) * 0.1,
            // child: SvgPicture.asset(logouk),
            child: Image.asset(
              logoPng,
              // fit: BoxFit.cover,
            ),
          ),
          InkWell(
              onTap: () {
                goRouter.pushNamed('home');
              },
              child: _linkPage(context, FontAwesomeIcons.pagelines, 'Home')),
          SizedBox(
            height: SizeConfig.screenHeight(context) * 0.02,
          ),
          InkWell(
              onTap: () {
                goRouter.pushNamed('searchPart');
              },
              child: _linkPage(
                  context, FontAwesomeIcons.magnifyingGlass, 'Search')),
          SizedBox(
            height: SizeConfig.screenHeight(context) * 0.02,
          ),
          InkWell(
              onTap: () {
                goRouter.pushNamed('lipiaKidogoKidogo');
              },
              child:
                  _linkPage(context, FontAwesomeIcons.coins, 'Kidogo Kidogo')),
          SizedBox(
            height: SizeConfig.screenHeight(context) * 0.02,
          ),
          InkWell(
              onTap: () {
                goRouter.pushNamed('listCart');
              },
              child: _linkPage(context, FontAwesomeIcons.dolly, 'Cart')),
          SizedBox(
            height: SizeConfig.screenHeight(context) * 0.02,
          ),
          InkWell(
              onTap: () {
                goRouter.pushNamed('completedOrders');
              },
              child: _linkPage(context, FontAwesomeIcons.gift, 'Orders')),
          SizedBox(
            height: SizeConfig.screenHeight(context) * 0.02,
          ),
          InkWell(
              onTap: () {
                goRouter.pushNamed('delivery');
              },
              child:
                  _linkPage(context, FontAwesomeIcons.truckFast, 'Delivery')),
          SizedBox(
            height: SizeConfig.screenHeight(context) * 0.02,
          ),
          InkWell(
              onTap: () {
                goRouter.pushNamed('privacyAndPolicy');
              },
              child: _linkPage(
                  context, FontAwesomeIcons.userLock, 'Privacy&Policy')),
          SizedBox(
            height: SizeConfig.screenHeight(context) * 0.02,
          ),
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
              child: _linkPage(
                  context, FontAwesomeIcons.whatsapp, 'Contact Support')),
          SizedBox(
            height: SizeConfig.screenHeight(context) * 0.02,
          ),
          InkWell(
              onTap: () {
                var url = 'https://www.instagram.com/ommyfitness_app/';

                void launchURL() async {
                  if (!await launchUrl(Uri.parse(url),
                      mode: LaunchMode.externalApplication)) {
                    throw 'Could not launch $url';
                  }
                }

                launchURL();
              },
              child:
                  _linkPage(context, FontAwesomeIcons.instagram, 'Instagram')),
          SizedBox(
            height: SizeConfig.screenHeight(context) * 0.02,
          ),
          InkWell(
              onTap: () {
                var url = 'https://twitter.com/ommyfitness_app';

                void launchURL() async {
                  if (!await launchUrl(Uri.parse(url),
                      mode: LaunchMode.externalApplication)) {
                    throw 'Could not launch $url';
                  }
                }

                launchURL();
              },
              child: _linkPage(context, FontAwesomeIcons.twitter, 'Twitter')),
        ],
      ),
    );
  }
}

Widget _linkPage(context, IconData icon, String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 22.0,
      horizontal: 15,
    ),
    child: Row(
      children: [
        Icon(
          icon,
          color: Colors.white.withOpacity(0.8),
          size: 15,
        ),
        SizedBox(
          width: SizeConfig.screenWidth(context) * 0.02,
        ),
        Text(
          title,
          style: const TextStyle(
            // fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

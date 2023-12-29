import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:ommyfitness/common/sizeConfig.dart';
import 'package:ommyfitness/utils/colours.dart';
import 'package:ommyfitness/utils/images.dart';
import 'package:ommyfitness/utils/routes.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// you can add more fields that meet your needs
  final double height;
  final String title;
  final Color color;
  final Color titlecolor;
  const MyAppBar(
      {this.title = '',
      this.color = purpleBackgroundColor,
      this.titlecolor = Colors.black,
      this.height = kToolbarHeight,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SizeConfig(context);
    return SafeArea(
      child: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: color,
        centerTitle: true,
        title: ResponsiveValue(
          context,
          defaultValue: Image.asset(
            logoPng,
            height: kToolbarHeight,
            // fit: BoxFit.cover,
          ),
          valueWhen: [
            Condition.smallerThan(
              name: TABLET,
              value: Image.asset(
                logoPng,
                height: kToolbarHeight,
                fit: BoxFit.cover,
              ),
            ),
            Condition.largerThan(
              name: MOBILE,
              value: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appBarLinks(() {
                    goRouter.pushNamed('completedOrders');
                  }, 'Orders'),
                  appBarLinks(() {
                    goRouter.pushNamed('lipiaKidogoKidogo');
                  }, 'Lipia Kidogo Kidogo'),
                  appBarLinks(() {
                    goRouter.pushNamed('delivery');
                  }, 'Delivery'),
                ],
              ),
            )
          ],
        ).value,
        actions: [
          appBarIconLink(FontAwesomeIcons.magnifyingGlass, () {
            goRouter.pushNamed('searchPart');
          }, "Search"),
          SizedBox(
            width: SizeConfig.screenWidth(context) * 0.03,
          ),
          appBarIconLink(FontAwesomeIcons.cartShopping, () {
            goRouter.pushNamed('listCart');
          }, "Cart"),
          SizedBox(
            width: SizeConfig.screenWidth(context) * 0.03,
          )
        ],
        elevation: 0.0,
      ),
    );
  }

  Widget appBarIconLink(IconData? icon, void Function()? onTap, String title) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Icon(
              icon,
              color: Colors.white,
              size: 12,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          )
        ]),
      ),
    );
  }

  Widget appBarLinks(void Function()? onTap, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: InkWell(
        onTap: onTap,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

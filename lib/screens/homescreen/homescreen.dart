import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ommyfitness/common/sizeConfig.dart';
import 'package:ommyfitness/screens/account/account_page.dart';
import 'package:ommyfitness/screens/home/homepage.dart';
import 'package:ommyfitness/screens/madini/madini_page.dart';
import 'package:ommyfitness/screens/videos/videos_page.dart';
import 'package:ommyfitness/utils/colours.dart';

class HomeScreenPage extends ConsumerStatefulWidget {
  const HomeScreenPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends ConsumerState<HomeScreenPage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    // const SearchPage(),
    const MadiniPage(),
    const VideosPage(),
    // const EbooksPage(),
    const AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  SafeArea bottomNavigationBarMethod(context) {
    return SafeArea(
      child: SizedBox(
        height: SizeConfig.screenHeight(context) * 0.08,
        child: BottomNavigationBar(
          elevation: 0.5,
          backgroundColor: whiteBackgroundColor,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black.withOpacity(0.4),
          selectedItemColor: blackColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.spa,
              ),
              label: 'Home',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     FontAwesomeIcons.magnifyingGlass,
            //   ),
            //   label: 'Search',
            // ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.gem,
              ),
              label: 'Madini',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.circlePlay,
              ),
              label: 'Videos',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     FontAwesomeIcons.bookOpenReader,
            //   ),
            //   label: 'Ebooks',
            // ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.circleUser,
              ),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBarMethod(context),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
